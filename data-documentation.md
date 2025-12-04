📘 University Portal — Updated Dataset Documentation
(Clean Markdown Version — No Formatting Issues)

# 📘 University Portal — Updated Dataset Documentation
هذا الملف يوضح شكل البيانات الجديدة بعد إعادة توليد الـ dataset باستخدام Faker،
والتي تشمل Students, Courses, Programs, Instructors فقط.

---

## 📁 1) Dataset Summary

| Dataset       | Count | Notes                              |
|---------------|-------|------------------------------------|
| Students      | 100   | 8% فقط لديهم Failed courses        |
| Courses       | 40    | كل كورس له Instructor              |
| Instructors   | 20    | المدرس يدرّس أكثر من مساق          |
| Programs      | 5     | لكل برنامج 5 required courses      |
| Activity Logs | —     | غير موجود                          |
| Redis Sessions| —     | غير موجود                          |
| Neo4j Graph   | —     | غير موجود                          |

---

## 👨‍🎓 2) Students (MongoDB – Document)

### Structure
```json
{
  "student_id": "ST1234",
  "name": "John Doe",
  "email": "john@ppu.edu",
  "phone": "0599XXXXXX",
  "program_id": "CSE",
  "year": 3,
  "status": "Active",
  "enrollment": [
    {
      "course_id": "CSE320",
      "course_name": "Algorithms",
      "semester": "2024/1",
      "status": "Completed",
      "grade": 75
    }
  ]
}
✔ يحتوي الطالب بين 3–6 مواد
✔ فقط 8% من الطلاب لديهم مواد Failed
    
---
    
## 📚 3) Courses (MongoDB – Document)
### Structure
```json 
{
  "course_id": "CSE220",
  "course_name": "Computer Architecture",
  "credits": 3,
  "instructor_id": "INS101",
  "level": "Junior"
}
✔ لا يحتوي على prerequisites
✔ كل كورس مرتبط بمدرّس واحد

---
    
## 👨‍🏫 4) Instructors (MongoDB – Document)
### Structure
```json   
{
  "instructor_id": "INS101",
  "name": "Dr. Ahmad Yaseen",
  "email": "ahmad@ppu.edu",
  "department": "Computer Engineering",
  "office": "C-415",
  "office_hours": "Mon 12-2"
}
✔ عدد المدرسين = 20
✔ المدرّس قد يدرّس أكثر من مساق
    
---
    
##  🏛 5) Programs (MongoDB – Document)
### Structure
```json              
{
  "program_id": "CSE",
  "name": "CSE Program",
  "department": "Engineering",
  "degree": "Bachelor",
  "duration_years": 5,
  "total_credits": 162,
  "required_courses": [
    "CSE101",
    "CSE230",
    "CSE250",
    "CSE320",
    "CSE350"
  ]
}
✔ يوجد 5 برامج
✔ كل برنامج له 5 كورسات Required
    
---
    
❌ Models Not Included in This Release
Model	Status
Activity Logs	غير موجود
Redis Sessions	غير موجود
Neo4j Graph	غير موجود

---

