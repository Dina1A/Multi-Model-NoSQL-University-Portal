CREATE KEYSPACE university
WITH replication = {
  'class': 'NetworkTopologyStrategy',
  'datacenter1': 3
};

USE university;

CREATE TABLE student_activity (
  student_id text,
  course_id text,
  activity_date date,
  activity_time timestamp,
  activity_type text,
  metadata map<text, text>,
  PRIMARY KEY ((student_id, course_id), activity_date, activity_time)
)
WITH CLUSTERING ORDER BY (activity_date DESC, activity_time DESC);

CREATE TABLE student_activity_by_student (
  student_id text,
  course_id text,
  activity_date date,
  activity_time timestamp,
  activity_type text,
  metadata map<text, text>,
  PRIMARY KEY (student_id, course_id, activity_date, activity_time)
)
WITH CLUSTERING ORDER BY (course_id ASC, activity_date DESC, activity_time DESC);



-- STU001
INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE001','2025-05-01','2025-05-01 09:10:00','login', {'device':'laptop','ip':'10.0.0.1'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE001','2025-05-01','2025-05-01 09:30:00','quiz_submission', {'quiz_id':'Q1','score':'85'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE001','2025-05-02','2025-05-02 10:00:00','attendance', {'lecture':'Week5'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE014','2025-05-03','2025-05-03 14:00:00','login', {'device':'tablet'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE014','2025-05-03','2025-05-03 14:40:00','assignment_submission', {'assignment':'A1'});

-- STU002
INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU002','COURSE014','2025-05-01','2025-05-01 10:00:00','login', {'device':'mobile'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU002','COURSE014','2025-05-01','2025-05-01 10:20:00','attendance', {'lecture':'Week4'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU002','COURSE014','2025-05-02','2025-05-02 11:00:00','quiz_submission', {'quiz_id':'Q2','score':'90'});

-- STU003
INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU003','COURSE018','2025-05-02','2025-05-02 13:20:00','login', {'device':'laptop'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU003','COURSE018','2025-05-02','2025-05-02 13:50:00','quiz_submission', {'quiz_id':'Q1','score':'88'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU003','COURSE018','2025-05-03','2025-05-03 15:00:00','attendance', {'lecture':'Week6'});

-- STU004
INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU004','COURSE010','2025-05-04','2025-05-04 16:00:00','login', {'device':'desktop'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU004','COURSE010','2025-05-04','2025-05-04 16:30:00','attendance', {'lecture':'Week6'});

INSERT INTO student_activity (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU004','COURSE010','2025-05-05','2025-05-05 17:00:00','assignment_submission', {'assignment':'A2'});



-- STU001
INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE001','2025-05-01','2025-05-01 09:10:00','login', {'device':'laptop','ip':'10.0.0.1'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE001','2025-05-01','2025-05-01 09:30:00','quiz_submission', {'quiz_id':'Q1','score':'85'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE001','2025-05-02','2025-05-02 10:00:00','attendance', {'lecture':'Week5'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE014','2025-05-03','2025-05-03 14:00:00','login', {'device':'tablet'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU001','COURSE014','2025-05-03','2025-05-03 14:40:00','assignment_submission', {'assignment':'A1'});

-- STU002
INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU002','COURSE014','2025-05-01','2025-05-01 10:00:00','login', {'device':'mobile'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU002','COURSE014','2025-05-01','2025-05-01 10:20:00','attendance', {'lecture':'Week4'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU002','COURSE014','2025-05-02','2025-05-02 11:00:00','quiz_submission', {'quiz_id':'Q2','score':'90'});

-- STU003
INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU003','COURSE018','2025-05-02','2025-05-02 13:20:00','login', {'device':'laptop'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU003','COURSE018','2025-05-02','2025-05-02 13:50:00','quiz_submission', {'quiz_id':'Q1','score':'88'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU003','COURSE018','2025-05-03','2025-05-03 15:00:00','attendance', {'lecture':'Week6'});

-- STU004
INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU004','COURSE010','2025-05-04','2025-05-04 16:00:00','login', {'device':'desktop'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU004','COURSE010','2025-05-04','2025-05-04 16:30:00','attendance', {'lecture':'Week6'});

INSERT INTO student_activity_by_student (student_id, course_id, activity_date, activity_time, activity_type, metadata)
VALUES ('STU004','COURSE010','2025-05-05','2025-05-05 17:00:00','assignment_submission', {'assignment':'A2'});
