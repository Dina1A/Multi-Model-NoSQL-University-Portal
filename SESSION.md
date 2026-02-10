
## **Session Component – Requirement Analysis & Database Selection**

---

## #️⃣ 1. Overview

A **Session** represents the authenticated state of a user within the system.
When a student, instructor, or admin logs in, the system generates a temporary session that keeps the user authenticated and stores short-lived information needed for fast access.

Sessions are **not permanent data** → they are temporary, frequently accessed, and expire after a short period.
Therefore, they must be stored in a **fast in-memory NoSQL database**.

---

## #️⃣ 2. Purpose of the Session Component

The session system is responsible for:

* Managing login states
* Validating authenticated requests
* Storing temporary user-related data
* Expiring sessions automatically after a fixed time
* Improving performance through caching
* Reducing repeated queries to the main databases

This makes the session component part of the **Caching Layer** in the overall system architecture.

---

## #️⃣ 3. Entity Definition (Session)

### **Session Fields**

| Field Name     | Type          | Description                                             |
| -------------- | ------------- | ------------------------------------------------------- |
| `session_id`   | String (UUID) | Unique identifier for each session                      |
| `user_id`      | String        | ID of the authenticated user (student/instructor/admin) |
| `role`         | String        | User role: `"student"`, `"instructor"`, or `"admin"`    |
| `created_at`   | Timestamp     | Time when the session was created                       |
| `expires_at`   | Timestamp     | Time when the session will expire                       |
| `session_data` | JSON / Hash   | Cached data such as recent profile info or activity     |

---

## #️⃣ 4. Why Redis is the Best Choice for Sessions

We choose **Redis** (Key–Value NoSQL database) for Session storage.

### ✔ Reasons for Selecting Redis:

#### **1. In-Memory Speed**

Redis stores data in RAM →
retrieval and validation of sessions happen in **microseconds**.

#### **2. TTL (Time-To-Live) Support**

Each session automatically expires after a specified time.
This perfectly matches login session behavior.

Example:

```text
SETEX session:<id> 3600 <value>
```

→ expires after 1 hour.

#### **3. Simple Key–Value Structure**

Sessions naturally fit this form:

```
key: session:<session_id>
value: JSON object
```

#### **4. Ideal for Caching**

Instead of querying the main database repeatedly:

* Load user profile once
* Cache it inside session_data
* Serve it quickly on every API call

#### **5. High Scalability**

Redis handles thousands of concurrent users efficiently.

---

## #️⃣ 5. Session Use Cases

### **UC-S1: Create Session (Login)**

**Actor:** Student / Instructor / Admin
**Steps:**

1. User logs into the system
2. Credentials validated in MongoDB
3. Session is generated with unique ID
4. Session stored in Redis with TTL
5. System returns session token

---

### **UC-S2: Validate Session**

**Actor:** System
**Steps:**

1. API receives request containing session token
2. System checks Redis
3. If session exists → grant access
4. If missing/expired → return Unauthorized

---

### **UC-S3: Refresh Session**

**Actor:** System
**Steps:**

1. Extend session lifetime (update TTL)
2. Update stored session_data if needed

---

### **UC-S4: Destroy Session (Logout)**

**Actor:** User
**Steps:**

1. Redis key is deleted
2. User becomes logged-out

---

## #️⃣ 6. Data Model (Conceptual)

### **Key Format**

```
session:<session_id>
```

### **Value Format**

Stored as JSON or Redis Hash:

#### **Option 1: JSON**

```json
{
  "user_id": "ST2043",
  "role": "student",
  "created_at": "2025-11-19T20:00:00",
  "expires_at": "2025-11-19T22:00:00",
  "session_data": {
    "cached_profile": true,
    "recent_courses": ["CS101", "AI201"]
  }
}
```

#### **Option 2: Redis Hash**

```
HSET session:<id> user_id "ST2043"
HSET session:<id> role "student"
HSET session:<id> created_at "..."
HSET session:<id> expires_at "..."
```

---

## #️⃣ 7. Responsibilities in the System Architecture

The session component interacts with:

| Layer           | Interaction                                         |
| --------------- | --------------------------------------------------- |
| **Backend API** | Creates, validates, refreshes, and deletes sessions |
| **MongoDB**     | Loads user profile once then caches it              |
| **Redis**       | Stores all active sessions                          |
| **Neo4j**       | (Optional) Cache graph traversal results            |
| **Cassandra**   | (Optional) Cache analytics summaries                |

---

## #️⃣ 8. Summary

The Session component handles authentication states and caching.
It uses **Redis** because it is fast, scalable, supports TTL, and fits the key-value pattern.
This component improves overall system performance and is essential for the caching layer.

