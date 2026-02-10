"""
Session Management Component using Redis
Author: Zainab Qabajah
Part of: Multi-Model-NoSQL-University-Portal Project

This module handles:
- Creating sessions with TTL
- Retrieving sessions
- Refreshing (extending TTL)
- Deleting sessions
- Bulk generation for testing

Redis Schema:
Key: session:<session_id>
Value: JSON object representing a session
"""

import redis
import uuid
import json
from datetime import datetime, timedelta


# --------------------------------------------------
# 1. Redis Connection (Docker-based)
# --------------------------------------------------
redis_client = redis.Redis(
    host="localhost",        # inside Docker → port mapped to 6379
    port=6379,
    decode_responses=True
)


# --------------------------------------------------
# 2. Create Session
# --------------------------------------------------
def create_session(user_id: str, role: str, ttl_seconds: int = 7200) -> dict:
    """
    Create a new session for a user.

    Args:
        user_id (str): ID of student/instructor/admin.
        role (str): User role.
        ttl_seconds (int): Session expiry in seconds (default: 2 hours).

    Returns:
        dict: Session object stored in Redis.
    """

    session_id = str(uuid.uuid4())
    created_at = datetime.utcnow().isoformat()
    expires_at = (datetime.utcnow() + timedelta(seconds=ttl_seconds)).isoformat()

    session_obj = {
        "session_id": session_id,
        "user_id": user_id,
        "role": role,
        "created_at": created_at,
        "expires_at": expires_at
    }

    redis_key = f"session:{session_id}"

    # Store with TTL
    redis_client.setex(redis_key, ttl_seconds, json.dumps(session_obj))

    return session_obj


# --------------------------------------------------
# 3. Get Session
# --------------------------------------------------
def get_session(session_id: str) -> dict | None:
    """
    Retrieve a session by ID.

    Args:
        session_id (str): The session ID.

    Returns:
        dict or None
    """

    key = f"session:{session_id}"
    raw_data = redis_client.get(key)

    return json.loads(raw_data) if raw_data else None


# --------------------------------------------------
# 4. Refresh Session
# --------------------------------------------------
def refresh_session(session_id: str, extra_seconds: int = 3600) -> dict | None:
    """
    Extend the lifetime of an existing session.

    Args:
        session_id (str): ID of the session.
        extra_seconds (int): Additional TTL.

    Returns:
        dict or None: Session data before refresh.
    """
    key = f"session:{session_id}"
    data = redis_client.get(key)

    if not data:
        return None

    redis_client.expire(key, extra_seconds)
    return json.loads(data)


# --------------------------------------------------
# 5. Delete Session
# --------------------------------------------------
def delete_session(session_id: str) -> bool:
    """
    Delete a session from Redis.

    Returns:
        True if deleted, False otherwise.
    """
    result = redis_client.delete(f"session:{session_id}")
    return result == 1


# --------------------------------------------------
# 6. Bulk Session Generator (for testing)
# --------------------------------------------------
def generate_fake_sessions(n: int = 10) -> list:
    """
    Generate a list of fake sessions (used for testing).

    Args:
        n (int): Number of sessions.

    Returns:
        list of session objects.
    """
    sessions = []
    for i in range(n):
        s = create_session(f"ST{2000+i}", "student")
        sessions.append(s)
    return sessions


# --------------------------------------------------
# 7. Manual Test Runner
# --------------------------------------------------
if __name__ == "__main__":
    print("Generating 3 test sessions...\n")
    test_sessions = generate_fake_sessions(3)
    for s in test_sessions:
        print(s, "\n")
