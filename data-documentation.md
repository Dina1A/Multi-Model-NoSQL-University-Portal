

# 📘 Multi-Model University Portal — Updated Dataset Documentation  
*(after entity structure modifications)*

هذا الملف يشرح **شكل البيانات الجديد** بعد التعديلات على الـ entities، وكيف تم توزيع البيانات على قواعد NoSQL المختلفة:

- MongoDB (Students – Courses – Programs – Time-Series Activity Logs)
- Redis (Sessions)
- Neo4j (Graph Relationships)

---

# 🟦 1. Students Dataset (MongoDB – Document)

**المسار:** `students.json`  
**العدد:** 200 طالب (أو حسب التوليد)

### ✔ الخصائص (Attributes)
- `student_id`
- `name`
- `email`
- `phone`
- `program_id`
- `year`
- `status`
- **enrollment (embedded array)**

### ✔ بنية الـ Enrollment بعد التعديل
```json
{
  "course_name": "Advanced Microprocessors",
  "grade": 92,
  "semester": "2023/2",
  "status": "Completed"
}
ملاحظة
استخدمنا course_name بدل course_id داخل enrollment، حسب التعديل الجديد.

🟩 2. Courses Dataset (MongoDB – Document)
المسار: courses.json
العدد: 40 مساق

✔ الخصائص الجديدة (Updated Attributes)
json
Copy code
{
  "course_id": "CSE320",
  "name": "Advanced Microprocessors",
  "credits": 3,
  "instructor_id": "INS101",
  "prerequisites": ["CSE220"],
  "level": "Junior"
}
ملاحظة
المساق يحتوي على prerequisites

و level (Freshman / Sophomore / Junior / Senior)

🟥 3. Instructors Dataset (MongoDB – Document)
المسار: instructors.json
العدد: 15 دكتور

✔ الخصائص
json
Copy code
{
  "instructor_id": "INS101",
  "name": "Dr. Ahmad Yaseen",
  "email": "ahmad@ppu.edu",
  "department": "Computer Engineering",
  "office": "C-415",
  "office_hours": "Mon 12-2"
}
🟨 4. Programs Dataset (MongoDB – Document)
المسار: programs.json

✔ الخصائص
json
Copy code
{
  "program_id": "CSE",
  "name": "Computer Systems Engineering",
  "department": "Engineering",
  "degree": "Bachelor",
  "duration_years": 5,
  "total_credits": 162
}
🟧 5. Activity Logs (MongoDB – Time-Series)
المسار: activity_logs.json
يستخدم course_name + student_id بدل course_id.

✔ البنية الجديدة
json
Copy code
{
  "timestamp": "2025-02-14T12:45:00",
  "meta": {
    "student_id": "2023001",
    "course_name": "Advanced Microprocessors",
    "type": "login"
  },
  "details": {
    "device": "Chrome",
    "ip": "192.168.1.5"
  }
}
🟪 6. Redis Sessions Dataset (Key‑Value)
المسار: sessions_redis.json

✔ مثال
json
Copy code
{
  "key": "session:3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "value": {
    "session_id": "...",
    "user_id": "2023001",
    "role": "student",
    "created_at": "2025-02-15T10:34",
    "expires_at": "2025-02-15T12:34"
  }
}
🟦 7. Neo4j Graph (Nodes + Relationships)
المسار: neo4j_data.json

✔ Nodes
Students

Courses

Instructors

✔ Relationships
ENROLLED_IN
يربط:

student_id

course_name

TEACHES
يربط:

instructor_id

course_id

✔ مثال
json
Copy code
{
  "type": "ENROLLED_IN",
  "student_id": "2023001",
  "course_name": "Advanced Microprocessors"
}
🔷 8. ERD (Structured Text Diagram)
pgsql
Copy code
Student
 ├── student_id
 ├── name
 ├── program_id  → Program.program_id
 └── enrollment[]
       ├── course_name  → Course.name
       ├── grade
       ├── semester
       └── status

Course
 ├── course_id
 ├── name
 ├── prerequisites[]
 └── instructor_id → Instructor.instructor_id

Instructor
 ├── instructor_id
 ├── name
 └── teaches → Course.course_id

Program
 └── program_id

Activity Log (Time-Series)
 ├── timestamp
 ├── meta.student_id → Student.student_id
 └── meta.course_name → Course.name

Redis Sessions
 └── user_id → Student.student_id
🟣 9. Summary Table
Dataset	DB	Structure	Notes
Students	MongoDB	Embedded enrollment	Uses course_name
Courses	MongoDB	Document	Includes prerequisites + level
Instructors	MongoDB	Document	Includes office + office_hours
Programs	MongoDB	Document	Updated fields
Activity Logs	MongoDB Time-Series	timestamp + meta	Uses course_name
Sessions	Redis	Key–Value	Session management
Graph	Neo4j	Nodes + Relationships	ENROLLED_IN / TEACHES
