CREATE KEYSPACE university
WITH replication = {
  'class': 'SimpleStrategy',
  'replication_factor': 3
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

INSERT INTO student_activity (
  student_id, course_id, activity_date, activity_time, activity_type, metadata
) VALUES (
  'STU001',
  'COURSE001',
  '2025-05-01',
  '2025-05-01 09:10:00',
  'login',
  {'device': 'laptop', 'ip': '10.0.0.5'}
);

INSERT INTO student_activity VALUES (
  'STU001',
  'COURSE001',
  '2025-05-01',
  '2025-05-01 09:30:00',
  'quiz_submission',
  {'quiz_id': 'QZ01', 'score': '85'}
);

INSERT INTO student_activity VALUES (
  'STU001',
  'COURSE001',
  '2025-05-02',
  '2025-05-02 11:00:00',
  'attendance',
  {'lecture': 'Week5'}
);

INSERT INTO student_activity VALUES (
  'STU001',
  'COURSE014',
  '2025-05-03',
  '2025-05-03 14:00:00',
  'login',
  {'device': 'tablet'}
);

INSERT INTO student_activity VALUES (
  'STU001',
  'COURSE014',
  '2025-05-03',
  '2025-05-03 14:45:00',
  'assignment_submission',
  {'assignment_id': 'A1'}
);

INSERT INTO student_activity VALUES (
  'STU002',
  'COURSE014',
  '2025-05-01',
  '2025-05-01 10:00:00',
  'login',
  {'device': 'mobile'}
);

INSERT INTO student_activity VALUES (
  'STU002',
  'COURSE014',
  '2025-05-01',
  '2025-05-01 10:15:00',
  'attendance',
  {'lecture': 'Week4'}
);

INSERT INTO student_activity VALUES (
  'STU003',
  'COURSE018',
  '2025-05-02',
  '2025-05-02 13:20:00',
  'login',
  {'device': 'laptop'}
);

INSERT INTO student_activity VALUES (
  'STU003',
  'COURSE018',
  '2025-05-02',
  '2025-05-02 13:50:00',
  'quiz_submission',
  {'quiz_id': 'QZ02', 'score': '90'}
);

INSERT INTO student_activity VALUES (
  'STU004',
  'COURSE010',
  '2025-05-04',
  '2025-05-04 16:00:00',
  'login',
  {'device': 'desktop'}
);

INSERT INTO student_activity VALUES (
  'STU004',
  'COURSE010',
  '2025-05-04',
  '2025-05-04 16:30:00',
  'attendance',
  {'lecture': 'Week6'}
);

INSERT INTO student_activity VALUES (
  'STU002',
  'COURSE002',
  '2025-05-03',
  '2025-05-03 12:00:00',
  'login',
  {'device': 'laptop'}
);

INSERT INTO student_activity VALUES (
  'STU002',
  'COURSE002',
  '2025-05-03',
  '2025-05-03 12:40:00',
  'quiz_submission',
  {'quiz_id': 'QZ03', 'score': '78'}
);

INSERT INTO student_activity VALUES (
  'STU003',
  'COURSE006',
  '2025-05-04',
  '2025-05-04 09:00:00',
  'login',
  {'device': 'mobile'}
);

INSERT INTO student_activity VALUES (
  'STU003',
  'COURSE006',
  '2025-05-04',
  '2025-05-04 09:50:00',
  'assignment_submission',
  {'assignment_id': 'A2'}
);

INSERT INTO student_activity VALUES (
  'STU004',
  'COURSE007',
  '2025-05-05',
  '2025-05-05 10:30:00',
  'attendance',
  {'lecture': 'Week7'}
);

