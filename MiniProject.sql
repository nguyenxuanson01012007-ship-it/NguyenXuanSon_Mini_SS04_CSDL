CREATE DATABASE DB_OnlineLearning;
USE DB_OnlineLearning;

-- Phần I: Thiết kế & Tạo bảng (DDL)

-- 1. Bảng Sinh viên (Student)
CREATE TABLE STUDENT (
    StudentID VARCHAR(10) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Bảng Giảng viên (Teacher)
CREATE TABLE TEACHER (
    TeacherID VARCHAR(10) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

-- 3. Bảng Khóa học (Course)
CREATE TABLE COURSE (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(200) NOT NULL,
    Description TEXT,
    TotalSessions INT CHECK (TotalSessions > 0),
    TeacherID VARCHAR(10),
    
    -- Khai báo khóa ngoại trực tiếp
    FOREIGN KEY (TeacherID) REFERENCES TEACHER(TeacherID)
);

-- 4. Bảng Đăng ký học (Enrollment)
CREATE TABLE ENROLLMENT (
    StudentID VARCHAR(10) NOT NULL,
    CourseID VARCHAR(10) NOT NULL,
    EnrollmentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    foreign key (courseID) references course(courseID),
    foreign key (studentID) references student(studentID)
);

-- 5. Bảng Kết quả học tập (Score)
CREATE TABLE SCORE (
    StudentID VARCHAR(10) NOT NULL,
    CourseID VARCHAR(10) NOT NULL,
    MidtermScore DECIMAL(4,2) CHECK (MidtermScore >= 0 AND MidtermScore <= 10),
    FinalScore DECIMAL(4,2) CHECK (FinalScore >= 0 AND FinalScore <= 10),
    
    foreign key (studentID) references student(studentID),
    foreign key (courseID) references course(courseID)
);
-- Phần II: Nhập dữ liệu ban đầu

-- STUDENT
INSERT INTO STUDENT (StudentID, FullName, DateOfBirth, Email) VALUES
('SV01','Nguyen Van A', '2001-05-12', 'a.nguyen@email.com'),
('SV02','Tran Thi B', '2002-08-22', 'b.tran@email.com'),
('SV03','Le Van C', '2000-11-05', 'c.le@email.com'),
('SV04','Pham Thi D', '2003-01-15', 'd.pham@email.com'),
('SV05','Hoang Van E', '2001-09-30', 'e.hoang@email.com');

-- TEACHER
INSERT INTO TEACHER (TeacherID, FullName, Email) VALUES
('GC01','TS. Nguyen Tien F', 'f.nguyen@uni.edu'),
('GC02','ThS. Tran Dao G', 'g.tran@uni.edu'),
('GC03','GS. Le Ba H', 'h.le@uni.edu'),
('GC04','TS. Pham Tuan I', 'i.pham@uni.edu'),
('GC05','ThS. Vuong Ngoc K', 'k.vuong@uni.edu');

-- COURSE
INSERT INTO COURSE (CourseID, CourseName, Description, TotalSessions, TeacherID) VALUES
('K01','Toan Cao Cap 1', 'Dai so tuyen tinh', 15, 'GC01'),
('K02','Lap Trinh C++', 'Co ban den nang cao', 30, 'GC02'),
('K03','Co So Du Lieu', 'SQL va Relational DB', 20, 'GC03'),
('K04','Ky Nang Mem', 'Thuyet trinh va Giao tiep', 10, 'GC04'),
('K05','Cau Truc Du Lieu', 'CTDL va Thuat Toan', 25, 'GC02');

-- ENROLLMENT
INSERT INTO ENROLLMENT (StudentID, CourseID, EnrollmentDate) VALUES
('SV01', 'K02', '2026-01-10'),
('SV01', 'K03', '2026-01-11'),
('SV02', 'K03', '2026-01-12'),
('SV03', 'K01', '2026-01-15'),
('SV04', 'K04', '2026-01-16');

-- SCORE
INSERT INTO SCORE (StudentID, CourseID, MidtermScore, FinalScore) VALUES
('SV01', 'K02', 8.5, 9.0),
('SV01', 'K03', 7.0, 8.5),
('SV02', 'K03', 6.5, 7.0),
('SV03', 'K01', 9.0, 9.5);
-- PHẦN III: CẬP NHẬT DỮ LIỆU

UPDATE STUDENT 
SET Email = 'a.nguyen_updated@email.com' 
WHERE StudentID = 'SV01';

UPDATE COURSE 
SET Description = 'Khoa hoc C++ version 2026' 
WHERE CourseID = 'K02';

UPDATE SCORE 
SET FinalScore = 9.5 
WHERE StudentID = 'SV01' AND CourseID = 'K02';

-- PHẦN IV: XÓA DỮ LIỆU

DELETE FROM SCORE 
WHERE StudentID = 'SV03' AND CourseID = 'K01';

DELETE FROM ENROLLMENT 
WHERE StudentID = 'SV03' AND CourseID = 'K01';

-- PHẦN V: TRUY VẤN DỮ LIỆU

SELECT * FROM STUDENT;
SELECT * FROM TEACHER;
SELECT * FROM COURSE;
SELECT * FROM ENROLLMENT;
SELECT * FROM SCORE;
