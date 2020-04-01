USE test;

IF EXISTS (SELECT * FROM sysobjects WHERE NAME ='Student')
DROP TABLE Student
GO
CREATE TABLE Student(
	stu_id INT IDENTITY(1,1) PRIMARY KEY,
	stu_name VARCHAR(50) NOT NULL,
	gender NCHAR(1) NOT NULL,
	age INT NOT NULL,
	birthday DATETIME NOT NULL
)

if exists (select * from sysobjects where name='Teacher')
drop table Teacher
go
create table Teacher(
	t_id int identity(1,1) primary key,
	t_name varchar(50) not null,
	gender NCHAR(1) NOT NULL,
	experience int not null,
)

if exists (select * from sysobjects where name='Course')
drop table Course
go
create table Course(
	c_id int identity(1,1) primary key,
	course_name varchar(50),
	t_id int not null 
)

IF EXISTS (SELECT * FROM sysobjects WHERE NAME ='Grade')
DROP TABLE Grade
go
CREATE TABLE Grade(
	stu_id int,
	c_id int,
	score int not null,
)

if exists (select * from sysobjects where name ='FK_teacher_teach_course') 
alter table Course drop constraint FK_teacher_teach_course
go
alter table Course add constraint FK_teacher_teach_course foreign key(t_id) references Teacher(t_id) on delete cascade



if exists (select * from sysobjects where name ='FK_student_have_grade') 
alter table Grade drop constraint FK_student_have_grade
go
alter table Grade add constraint FK_student_have_grade foreign key(stu_id) references Student(stu_id) on delete set null

if exists (select * from sysobjects where name ='FK_in_which_course') 
alter table Grade drop constraint FK_in_which_course
go
alter table Grade add constraint FK_in_which_course foreign key(c_id) references Course(c_id) on delete set null




