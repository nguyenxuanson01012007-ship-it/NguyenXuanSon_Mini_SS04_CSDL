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
    
    -- Khai báo khóa chính kết hợp và khóa ngoại trực tiếp
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
);

-- 5. Bảng Kết quả học tập (Score)
CREATE TABLE SCORE (
    StudentID VARCHAR(10) NOT NULL,
    CourseID VARCHAR(10) NOT NULL,
    MidtermScore DECIMAL(4,2) CHECK (MidtermScore >= 0 AND MidtermScore <= 10),
    FinalScore DECIMAL(4,2) CHECK (FinalScore >= 0 AND FinalScore <= 10),
    
    -- Khai báo khóa chính kết hợp và khóa ngoại trực tiếp
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID, CourseID) REFERENCES ENROLLMENT(StudentID, CourseID)
);

-- Phần II: Nhập dữ liệu ban đầu

INSERT INTO STUDENT (FullName, DateOfBirth, Email) VALUES
('Nguyen Van A', '2001-05-12', 'a.nguyen@email.com'),
('Tran Thi B', '2002-08-22', 'b.tran@email.com'),
('Le Van C', '2000-11-05', 'c.le@email.com'),
('Pham Thi D', '2003-01-15', 'd.pham@email.com'),
('Hoang Van E', '2001-09-30', 'e.hoang@email.com');

INSERT INTO TEACHER (FullName, Email) VALUES
('TS. Nguyen Tien F', 'f.nguyen@uni.edu'),
('ThS. Tran Dao G', 'g.tran@uni.edu'),
('GS. Le Ba H', 'h.le@uni.edu'),
('TS. Pham Tuan I', 'i.pham@uni.edu'),
('ThS. Vuong Ngoc K', 'k.vuong@uni.edu');

INSERT INTO COURSE (CourseName, Description, TotalSessions, TeacherID) VALUES
('Toan Cao Cap 1', 'Dai so tuyen tinh', 15, 1),
('Lap Trinh C++', 'Co ban den nang cao', 30, 2),
('Co So Du Lieu', 'SQL va Relational DB', 20, 3),
('Ky Nang Mem', 'Thuyet trinh va Giao tiep', 10, 4),
('Cau Truc Du Lieu', 'CTDL va Thuat Toan', 25, 2);

INSERT INTO ENROLLMENT (StudentID, CourseID, EnrollmentDate) VALUES
(1, 2, '2026-01-10'), 
(1, 3, '2026-01-11'), 
(2, 3, '2026-01-12'), 
(3, 1, '2026-01-15'), 
(4, 4, '2026-01-16'); 

INSERT INTO SCORE (StudentID, CourseID, MidtermScore, FinalScore) VALUES
(1, 2, 8.5, 9.0),  
(1, 3, 7.0, 8.5),  
(2, 3, 6.5, 7.0),  
(3, 1, 9.0, 9.5);

-- PHẦN III: CẬP NHẬT DỮ LIỆU

UPDATE STUDENT SET Email = 'a.nguyen_updated@email.com' WHERE StudentID = 1;
UPDATE COURSE SET Description = 'Khoa hoc C++ version 2026' WHERE CourseID = 2;
UPDATE SCORE SET FinalScore = 9.5 WHERE StudentID = 1 AND CourseID = 2;

-- PHẦN IV: XÓA DỮ LIỆU

DELETE FROM SCORE WHERE StudentID = 3 AND CourseID = 1;
DELETE FROM ENROLLMENT WHERE StudentID = 3 AND CourseID = 1;

-- PHẦN V: TRUY VẤN DỮ LIỆU

SELECT * FROM STUDENT;
SELECT * FROM TEACHER;
SELECT * FROM COURSE;
SELECT * FROM ENROLLMENT;
SELECT * FROM SCORE;