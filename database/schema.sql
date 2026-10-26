-- Smart College Management System : DATABASE (SQLite)

CREATE TABLE IF NOT EXISTS department (
  dept_id   INTEGER PRIMARY KEY,
  dept_name TEXT NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS student (
  student_id INTEGER PRIMARY KEY ,
  roll_no    TEXT NOT NULL UNIQUE,
  name       TEXT NOT NULL,
  email      TEXT,
  year       INTEGER CHECK (year BETWEEN 1 AND 4),
  total_fee  REAL DEFAULT 0,
  dept_id    INTEGER NOT NULL REFERENCES department(dept_id)
);
CREATE TABLE IF NOT EXISTS course (
  course_id   INTEGER PRIMARY KEY ,
  course_name TEXT NOT NULL,
  credits     INTEGER DEFAULT 3,
  dept_id     INTEGER NOT NULL REFERENCES department(dept_id)
);
-- Many-to-many: a student takes many courses, a course has many students
CREATE TABLE IF NOT EXISTS enrollment (
  student_id INTEGER REFERENCES student(student_id) ON DELETE CASCADE,
  course_id  INTEGER REFERENCES course(course_id)   ON DELETE CASCADE,
  PRIMARY KEY (student_id, course_id)
);
CREATE TABLE IF NOT EXISTS attendance (
  att_id     INTEGER PRIMARY KEY ,
  student_id INTEGER NOT NULL REFERENCES student(student_id) ON DELETE CASCADE,
  course_id  INTEGER NOT NULL REFERENCES course(course_id)   ON DELETE CASCADE,
  att_date   TEXT NOT NULL,
  status     TEXT NOT NULL CHECK (status IN ('Present','Absent')),
  UNIQUE (student_id, course_id, att_date)
);
CREATE TABLE IF NOT EXISTS fee_payment (
  pay_id     INTEGER PRIMARY KEY ,
  student_id INTEGER NOT NULL REFERENCES student(student_id) ON DELETE CASCADE,
  amount     REAL NOT NULL CHECK (amount > 0),
  paid_on    TEXT DEFAULT CURRENT_DATE
);

-- Sample data
INSERT INTO department(dept_id, dept_name) VALUES
  (1, 'Computer Science'),
  (2, 'Electronics');

INSERT INTO course(course_id, course_name, credits, dept_id) VALUES
  (1, 'Database Management Systems', 4, 1),
  (2, 'Data Structures', 4, 1),
  (3, 'Digital Electronics', 3, 2);
INSERT INTO student(student_id,roll_no,name,email,year,total_fee,dept_id) VALUES
 (1,'CS101','Aarav Sen','aarav@college.edu',1,60000,1),
 (2,'CS102','Priya Das','priya@college.edu',2,60000,1),
 (3,'EC201','Rahul Roy','rahul@college.edu',3,55000,2);

INSERT INTO enrollment VALUES (1,1),(1,2),(2,1),(3,3)
ON CONFLICT(student_id, course_id) DO NOTHING;
INSERT INTO fee_payment(pay_id,student_id,amount) VALUES (1,1,60000),(2,2,30000)
ON CONFLICT(pay_id) DO NOTHING;