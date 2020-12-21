USE master
IF(DB_ID('Exam10Test') IS NOT NULL)
DROP DATABASE Exam10Test
ELSE DATABASE Exam10Test
GO
CREATE DATABASE Exam10Test
GO
USE Exam10Test
GO
CREATE TABLE Classes
(
ClassID int IDENTITY,
ClassName nvarchar(10),
CONSTRAINT PK_Classes PRIMARY KEY (ClassID),
CONSTRAINT UQ_ClassesClassName UNIQUE(ClassName)
)
GO
CREATE TABLE Students
(
RollNo varchar(6) CONSTRAINT PK_Students PRIMARY KEY,
FullName nvarchar(50) not null,
Email varchar(10) CONSTRAINT FK_StudentsEmail UNIQUE,
ClassName  nvarchar(10) CONSTRAINT FK_Students_Classes
FOREIGN KEY REFERENCES Classes(ClassName) ON UPDATE CASCADE
)
GO
CREATE INDEX IX_Email ON Students(Email)
--Tao bang subjects
GO
CREATE TABLE Subjects
(
SubjectID int,
SubjectName nvarchar(100)
)
GO
--tao chi muc Clustered
CREATE CLUSTERED INDEX IX_SubjectID
ON Subjects(SubjectID)
GO
--TAO CHI MUC NONCLUSTERED
CREATE NONCLUSTERED INDEX IX_SubjectName
ON Subjects(SubjectName)
GO
--TAO CHI MUC DUY NHAT
CREATE UNIQUE INDEX IX_UQ_SubjectName ON Subjects(SubjectName)
go
--TAO CHI MUC KET HOP
CREATE INDEX IX_Name_Email ON Students(FullName,Email)
GO
INSERT INTO Classes(ClassName) VALUES('T2007E'),('T2008E'),('T2010E');
SELECT *FROM Classes
GO
INSERT INTO Students(RollNo,FullName,Email,ClassName) VALUES ('C01',N'VŨ VĂN DIỆU','d.mail','T2007E');
GO
--XÓA CHỈ MỤC IX_SubjectID
DROP INDEX IX_SubjectID ON Subjects
GO
--TẠO CHỈ MỤC IX_SubjectID mới với tùy chọn PAD_INDEX và fillfactor
CREATE CLUSTERED INDEX IX_SubjectID ON Subjects(SubjectID)
WITH(PAD_INDEX =ON,FILLFACTOR =60)
GO
--XEM ĐỊNH NGHĨA CHỈ MỤC DÙNG SP_HELPTEXT VIẾT ĐẦY ĐỦ 'EXECUTE'
EXEC sp_helpindex 'Subjects'



