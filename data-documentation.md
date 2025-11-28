

# 📘 Multi-Model University Portal — Dataset Documentation

هذا الملف يشرح **الداتا** المستخدمة في مشروع الـ *Multi‑Model NoSQL Portal*  
ويلخص **هيكلية البيانات**، والعلاقات بينها، وكيف تم توزيعها بين قواعد البيانات المختلفة:

- MongoDB (Document + Time-Series)
- Redis (Key–Value)
- Neo4j (Graph)

---

# 🟦 1. Students Dataset (MongoDB – Document)

**المسار:** `students.json`  
**العدد:** 200 طالب (أو حسب التوليد)

يمثّل كل طالب كوثيقة (Document) في MongoDB.  
والميزة الأساسية: **enrollment embedded** داخل الطالب.

### **Structure**
```json
{
  "student_id": "ST1234",
  "name": "John Doe",
  "program_id": "PRG01",
  "enrollment": [
    {
      "course_name": "Introduction to Programming",
      "grade": 93
    },
    {
      "course_name": "Databases",
      "grade": 87
    }
  ]
}
ملاحظات
enrollment embedded array بدل العلاقات التقليدية.

كل عنصر يحتوي course_name + grade فقط.

🟨 2. Programs Dataset (MongoDB – Document)
المسار: programs.json

يمثل كل تخصص جامعي (Program):

{
  "program_id": "PRG01",
  "name": "Computer Science",
  "faculty": "IT",
  "degree_type": "BSc",
  "required_credits": 132,
  "duration_years": 4
}
🟩 3. Courses Dataset (MongoDB – Document)
المسار: courses.json

يمثل كل مساق:

{
  "course_id": "CS101",
  "course_name": "Introduction to Programming",
  "credits": 3,
  "level": 1,
  "department": "Computer Science"
}
ملاحظة مهمة
رغم إنّ الطالب يخزن course_name فقط،
إلا أن course_id موجود هنا لاستخدامه في:

Activity Logs

Neo4j graph relationships

🟥 4. Activity Logs Dataset (MongoDB – Time-Series)
المسار: activity_logs.json

تم تصميمه ليشتغل على Collection من نوع Time-Series.

Structure
{
  "timestamp": "2025-02-14T12:45:00",
  "meta": {
    "student_id": "ST1234",
    "course_id": "CS101",
    "type": "login"
  },
  "details": {
    "device": "Chrome",
    "ip": "192.168.1.5"
  }
}
لماذا Time-Series؟
لأن:

فيها وقت (timestamp)

Events كثيرة

مناسب للـ Analytics

🟧 5. Redis Sessions Dataset (Redis – Key/Value)
المسار: sessions_redis.json

يمثل الجلسات النشطة للطلاب:

{
  "key": "session:3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "value": {
    "session_id": "...",
    "user_id": "ST1234",
    "role": "student",
    "created_at": "2025-02-15T10:34",
    "expires_at": "2025-02-15T12:34"
  }
}
🟪 6. Neo4j Graph Data (Nodes + Relationships)
المسار: neo4j_data.json

يحتوي:

Nodes
Students

Courses

Instructors

Relationships
ENROLLED_IN

TEACHES

Example
{
  "type": "ENROLLED_IN",
  "student_id": "ST1234",
  "course_id": "CS101"
}
🔷 7. العلاقات بين مجموعات البيانات (ERD – نصّي)
Student
 └── enrollment[]
        └── course_name (maps to course_id in Courses)

Course
 └── instructor_id
         └── Instructors in Neo4j

Activity Log (Time-Series)
 ├── student_id → Student.student_id
 └── course_id  → Courses.course_id

Redis Sessions
 └── user_id → Student.student_id

Neo4j Graph
 ├── Node(Student)
 ├── Node(Course)
 ├── Node(Instructor)
 └── RELATIONS:
        - Student ENROLLED_IN Course
        - Instructor TEACHES Course
🔵 8. Summary
Dataset	Database	Structure	Purpose
Students	MongoDB	Document + Embedded enrollment	Student profiles
Programs	MongoDB	Document	Program definitions
Courses	MongoDB	Document	Course metadata
Activity Logs	MongoDB Time-Series	Event logs	Analytics + tracking
Redis Sessions	Redis	Key–Value	Session management
Neo4j Graph	Neo4j	Nodes + Relations	Visual graph connections
