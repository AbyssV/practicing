/*
结论
1. 如果有foreign key，删除时一定要先删除外表，再删除内表。不推荐foreign key写在表内，之后修改表会很难
2. not null, default, check等其他细节建表的时候要想好，not null之后on delete set null就不能用了
3. identity不要太好用。比如我想记录某个stu_id在某个course_id上的分数，stu_id和course_id都是不可以重复的。这时用identity就很方便
4. if...else...中需要嵌套
5. stored procedure 只能return一个int，这个int可以是状态值
6. docs很全，查docs
问题
1. link server是什么
*/
use test
go

--视图
--对视图一般不去执行增加删除和修改操作，但是一定需要注意的是，对视图的这些操作会直接影响原始的物理表.但是这些操作仅仅局限于单个表的操作，如果操作涉及到多个表就不会成功，比如主键外键
if exists (select * from sysobjects where name='vw_GradeToUpload')
drop view vw_GradeToUpload
go
create view vw_GradeToUpload as 
--select * from grade  视图中只能创建一个select查询  
--update grade  --不能在视图中创建update delete 和insert 
select Student.stu_id, Student.stu_name, Teacher.t_name, Course.course_name, Grade.score from 
Student inner join Grade on Student.stu_id=Grade.stu_id inner join Course on Grade.c_id=Course.c_id inner join Teacher on Course.t_id=Teacher.t_id
go
select * from vw_GradeToUpload
select * from vw_GradeToUpload order by t_name

--关于变量赋值
declare @name nvarchar(50) = '张三'
--declare @name varchar(50) = stu_name from Student where age = 15 --incorrect syntax
--set @name = (select stu_name from Student where age=7) --Mike 这两个subquery都一定要加()
--select @name = (select stu_name from Student where age=7) --Mike
--set @name = stu_name from Student where age=7 --Incorrect syntax near the keyword 'from'.
--select @name = stu_name from Student where age=7 --Mike
--set @name = (select stu_name from Student) 
/*Subquery returned more than 1 value. 
This is not permitted when the subquery follows =, !=, <, <= , >, >= or 
when the subquery is used as an expression.*/
--select @name = (select stu_name from Student) --same as above
--select @name =  stu_name from Student --Brown(last value)
--set @name = (select stu_name from Student where stu_id=1000) --空行
--select @name = (select stu_name from Student where stu_id=1000) --空行
select @name = stu_name from Student where stu_id=1000 --Amy
print @name+'123'
go

--transaction练习
if exists (select * from sysobjects where name = 'Bank') drop table Bank
create table Bank(
customer_id int identity(1,1) primary key,
customer_name varchar(50) unique,
balance decimal(10,2) check (balance > 0)
)
insert into Bank values ('a', 10.8)
insert into Bank values ('b', 40000)
insert into Bank values ('c', 200.3)
insert into Bank values ('d', 8790.21)
declare @error_sum int=0
begin transaction
update bank set balance-=1000 where customer_name='a'
set @error_sum +=@@ERROR

update bank set balance+=1000 where customer_name='b'
set @error_sum +=@@ERROR

if (@error_sum) <> 0
	rollback transaction
else
	commit transaction
print @error_sum
select * from bank

--stored procedure练习
exec sp_help Student
--查询参与某门课程考试的男女人数和各自的平均分
/*
 _  _ _
|男|_|_|
|女|_|_|
*/
if exists (select * from sysobjects where name ='usp_GradeBySex')
drop proc usp_GradeBySex
go

create proc usp_GradeBySex
@cid int = 1
as
select gender, 男女人数=count(*), 平均分=avg(score) from (select * from Grade where c_id=@cid) as temp join Student
on temp.stu_id = Student.stu_id group by gender
go
exec usp_GradeBySex @cid=6

--导出某位老师教导的某门课程的学生总数和平均分
--可以同时给两个变量赋值，即使他们使用的是同一张表
if exists (select * from sysobjects where name ='usp_GradeByTeacher')
drop proc usp_GradeByTeacher
go

create proc usp_GradeByTeacher
@stu_num int output,
@avg int output,
@tid int = 1,
@cid int=1
as
--而select支持一次为多个变量赋值
select @stu_num = count(*), @avg=avg(score) from (select * from Teacher where t_id=@tid) as temp_teacher join 
(select * from Course where c_id=@cid) as temp_course
on temp_teacher.t_id=temp_course.t_id join Grade 
on temp_course.c_id=Grade.c_id
--select @avg = avg(score) from (select * from Teacher where t_id=@tid) as temp_teacher join 
--(select * from Course where c_id=@cid) as temp_course
--on temp_teacher.t_id=temp_course.t_id join Grade 
--on temp_course.c_id=Grade.c_id
go
declare @stu_num int, @avg int --写在一行需要加逗号，写在两个declare里不需要加逗号

exec usp_GradeByTeacher @stu_num = @stu_num output, @avg = @avg output, @tid=4, @cid=2 --接收的变量重名不影响结果
print @stu_num
print @avg
print 'Over'

--Trigger
--给Student的stu_name字段添加unique的constraint，类似with nocheck
if exists (select * from sysobjects where name='tr_unique_stu_name')
drop trigger tr_unique_stu_name
go
create trigger tr_unique_stu_name on Student after insert 
as
begin
declare @name varchar(50)
declare @num int 
declare @max_id int
select * from inserted
select * from deleted
select @name = stu_name from inserted
select @num = count(*) from Student where stu_name=@name
select @max_id=max(stu_id) from Student
if @num>1
begin
print '已有重复值'
delete from Student where stu_name = @name and stu_id=@max_id
end
else
print '插入成功'
end
go
insert into Student values ('Kevin','男',30,'1980-2-1')

--index 
--聚集索引可以建在表的主键上,也可以建在其他键上;
--一个表可以建多个索引,但只能有一个聚集索引,其他的索引必须是非聚集索引;
--关于第1条需要说明的是,默认情况下,当创建主键时,如果没有明确指定主键为非聚集选项,并且表中不存在聚集索引,那么系统会为主键创建聚集索引.
if exists (select * from sysindexes where name = 'IX_student_name') --sysindexes
drop index Student.IX_student_name
go
create unique index  IX_student_name on Student(stu_name) --不能加cluster

--临时表
create table #tempstudent(
 --stu_id int,
 stu_name varchar(50),
 gender nchar(1),
 age int,
 birthday datetime
)
select * into #newtemp from Student
select * from #newtemp

--方便查询，但是不更改原表
select *, 类型='sb' from Student

--一些全局变量
select @@SERVICENAME 'Service Name',  @@FETCH_STATUS 'Fetch Status', @@SERVERNAME 'Server Name'
select * from Student
print '影响了' + cast(@@ROWCOUNT as varchar(20)) + '行'

--一些系统proc
exec sp_tables

--if语句判断
if (select count(*) from Student where stu_id=4)>0
select * from Student

--查找重复值
select * from Grade where score in (select score from Grade group by score having (1<count(*)))

--从10往下数11
--因为top是最后执行的，已经选好了结果集，随后选择结果集的前10个结果
select top 10 * from Teacher where t_id not in (select top 9 t_id from Teacher order by t_id asc) order by t_id asc 
select top 10 * from (select top 19 * from Teacher order by t_id asc) T order by t_id desc 
--注意：如果使用生成行号的结果集做为子查询，那么必须为结果集命别名，同时为行号添加名称
select * from (select ROW_NUMBER() over(order by t_id) id, * from Teacher) temp where id between 10 and 19

--ANY, ALL, INTERSECT, UNION, EXCEPT, 加all会保留重复值
if 3>all(select score from Grade)
	print '都在3分以上'
else
	print '有考3分以下的学生'

select * from Student 
union
select 2, 'Rick', '男', 10, '2005-4-5'
print @@FETCH_STATUS

--说明：包括所有在 TableA 中但不在 TableB和TableC 中的行并消除所有重复行而派生出一个结果表  
(select stu_name from Student ) except (select stu_name from new_table) except (select stu_name from new_table2)  

--复制表头
--1=1，1=2的使用，在SQL语句组合时用的较多 'where 1=1'是表示选择全部 'where 1=2'全部不选
select * into new_table from Student where 1<>1 --方法一
select top 0 * into new_table2 from Student --方法二
--跨数据库之间表的拷贝(具体数据使用绝对路径)
insert into Student(stu_name,gender,age, birthday) select 'Leo','男',15,'2014-3-1'

--修改字段的数据类型
alter table Teacher alter column[experience] int

-- 从数据库定位到表。
--Sqlserver写法：库名.dbo.表名 ；或者：库名..表名(注：中间使用两个点）
select stu_id from test..Student
--查询指定库中的所有表
select * from [test].[dbo].[sysobjects] where [type] = 'U'
--查看当前数据库中所有存储过程
select name as 存储过程名称 from sysobjects where type='P'  
--列出表里的所有的字段
select name from syscolumns where id=object_id('Grade')
--查询某一个表的字段和数据类型  
select column_name,data_type from information_schema.columns where table_name = 'Teacher'  
--查看与某一个表相关的视图、存储过程、函数  
select a.* from sysobjects a, syscomments b where a.id = b.id and b.text like '%Student%'  

--随机取出10条数据
select top 10 * from Student order by newid()

--使用SQL语句 用…代替过长的字符串显示
select iif(len(stu_name)>2, left(stu_name, 2)+'...', stu_name) from Student

--使返回的结果中不包含有关受 Transact-SQL 语句影响的行数的信息。如果存储过程中包含的一些语句并不返回许多实际的数据，则该设置由于大量减少了网络流量，因此可显著提高性能。SET NOCOUNT 设置是在执行或运行时设置，而不是在分析时设置。  
--SET NOCOUNT 为 ON 时，不返回计数（表示受 Transact-SQL 语句影响的行数）。  
--SET NOCOUNT 为 OFF 时，返回计数  
set nocount off

/*没用过，不知道好不好用
--查询用户创建的所有数据库  
select * from master..sysdatabases D where sid not in(select sid from master..syslogins where name='sa')  
--或者  
select dbid, name AS DB_NAME from master..sysdatabases where sid <> 0x01  
--判断是否存在某个数据库，若存在，则删除
if DB_ID('test') IS NOT NULL drop database test
--若sqlserver数据库正在使用中，删除之前，先要把数据库变成'单一用户'，再删除
ALTER DATABASE users SET SINGLE_USER with ROLLBACK IMMEDIATE IF DB_ID('users') IS NOT NULL DROP DATABASE users
--创建 备份数据的 device  
USE master
EXEC sp_addumpdevice 'disk', 'testBack', 'c:\mssql7backup\MyNwind_1.dat' 
--开始 备份  
BACKUP DATABASE pubs TO testBack  
--对数据库进行操作：  
分离数据库： sp_detach_db; 附加数据库：sp_attach_db 后接表明，附加需要完整的路径名  
--如何修改数据库的名称:  
sp_renamedb 'old_name', 'new_name'  
--重建索引  
DBCC REINDEX  
DBCC INDEXDEFRAG  
--收缩数据和日志  
DBCC SHRINKDB  
DBCC SHRINKFILE  
--压缩数据库  
DBCC shrinkdatabase(dbname)  
--转移数据库给新用户以已存在用户权限  
exec sp_change_users_login 'update_one','newname','oldname'  
go  
--检查备份集  
RESTORE VERIFYONLY from disk='E:\dvbbs.bak'  
--修复数据库  
ALTER DATABASE [dvbbs] SET SINGLE_USER  
GO  
DBCC CHECKDB('dvbbs',repair_allow_data_loss) WITH TABLOCK  
GO  
ALTER DATABASE [dvbbs] SET MULTI_USER  
GO  
--查看硬盘分区:  
EXEC master..xp_fixeddrives 
--比较A,B表是否相等
if (select checksum_agg(binary_checksum(*)) from Student)  
= (select checksum_agg(binary_checksum(*)) from Teacher)  
print '相等'  
else  
print '不相等'  
*/

--创建链接服务器  
exec sp_addlinkedserver 'ITSV ', ' ', 'SQLOLEDB ', '远程服务器名或ip地址 '  
exec sp_addlinkedsrvlogin 'ITSV ', 'false ',null, '用户名 ', '密码 '  
--查询示例  
select * from ITSV.数据库名.dbo.表名  
--导入示例  
select * into 表 from ITSV.数据库名.dbo.表名  
--以后不再使用时删除链接服务器  
exec sp_dropserver 'ITSV ', 'droplogins '  
--连接远程/局域网数据(openrowset/openquery/opendatasource)  
--1、openrowset  
--查询示例  
select * from openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名)  
--生成本地表  
select * into 表 from openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名)  
--把本地表导入远程表  
insert openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名) select *from 本地表  
--更新本地表  
update b set b.列A=a.列A from openrowset( 'SQLOLEDB ', 'sql服务器名 '; '用户名 '; '密码 ',数据库名.dbo.表名)as a inner join 本地表 b   
on a.column1=b.column1  
--openquery用法需要创建一个连接  
--首先创建一个连接创建链接服务器  
exec sp_addlinkedserver 'ITSV ', ' ', 'SQLOLEDB ', '远程服务器名或ip地址 '  
--查询  
select * FROM openquery(ITSV, 'SELECT * FROM 数据库.dbo.表名 ')  
--把本地表导入远程表  
insert openquery(ITSV, 'SELECT * FROM 数据库.dbo.表名 ')  
select * from 本地表  
--更新本地表  
update b set b.列B=a.列B FROM openquery(ITSV, 'SELECT * FROM 数据库.dbo.表名 ') as a inner join 本地表 b on a.列A=b.列A  
--3、opendatasource/openrowset  
SELECT * ROM opendatasource( 'SQLOLEDB ', 'Data Source=ip/ServerName;User ID=登陆名;Password=密码 ' ).test.dbo.roy_ta  
--把本地表导入远程表  
insert opendatasource( 'SQLOLEDB ', 'Data Source=ip/ServerName;User ID=登陆名;Password=密码 ').数据库.dbo.表名  
select * from 本地表