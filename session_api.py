from flask import Flask, request, jsonify
from redis_session_generator import (
    create_session,
    get_session,
    refresh_session,
    delete_session
)

app = Flask(__name__)

# -------------------------------
# Create Session  (POST)
# -------------------------------
@app.post("/session/create")
def create():
    try:
        data = request.json
        user_id = data.get("user_id")
        role = data.get("role")

        if not user_id or not role:
            return jsonify({"error": "user_id and role are required"}), 400

        session = create_session(user_id, role)
        return jsonify(session)

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# -------------------------------
# Get Session by ID (GET)
# -------------------------------
@app.get("/session/<sid>")
def get(sid):
    session = get_session(sid)
    if session:
        return jsonify(session)
    return jsonify({"error": "Session not found"}), 404


# -------------------------------
# Refresh Session TTL  (POST)
# -------------------------------
@app.post("/session/refresh/<sid>")
def refresh(sid):
    session = refresh_session(sid)
    if session:
        return jsonify({"message": "TTL refreshed", "session": session})
    return jsonify({"error": "Session not found"}), 404


# -------------------------------
# Delete Session  (DELETE)
# -------------------------------
@app.delete("/session/<sid>")
def delete(sid):
    deleted = delete_session(sid)
    if deleted:
        return jsonify({"deleted": True})
    return jsonify({"deleted": False, "error": "Session not found"}), 404


# -------------------------------
# main
# -------------------------------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
