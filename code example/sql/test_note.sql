/*
����
1. �����foreign key��ɾ��ʱһ��Ҫ��ɾ�������ɾ���ڱ����Ƽ�foreign keyд�ڱ��ڣ�֮���޸ı�����
2. not null, default, check������ϸ�ڽ����ʱ��Ҫ��ã�not null֮��on delete set null�Ͳ�������
3. identity��Ҫ̫���á����������¼ĳ��stu_id��ĳ��course_id�ϵķ�����stu_id��course_id���ǲ������ظ��ġ���ʱ��identity�ͺܷ���
4. if...else...����ҪǶ��
5. stored procedure ֻ��returnһ��int�����int������״ֵ̬
6. docs��ȫ����docs
����
1. link server��ʲô
*/
use test
go

--��ͼ
--����ͼһ�㲻ȥִ������ɾ�����޸Ĳ���������һ����Ҫע����ǣ�����ͼ����Щ������ֱ��Ӱ��ԭʼ�������.������Щ�������������ڵ�����Ĳ�������������漰�������Ͳ���ɹ��������������
if exists (select * from sysobjects where name='vw_GradeToUpload')
drop view vw_GradeToUpload
go
create view vw_GradeToUpload as 
--select * from grade  ��ͼ��ֻ�ܴ���һ��select��ѯ  
--update grade  --��������ͼ�д���update delete ��insert 
select Student.stu_id, Student.stu_name, Teacher.t_name, Course.course_name, Grade.score from 
Student inner join Grade on Student.stu_id=Grade.stu_id inner join Course on Grade.c_id=Course.c_id inner join Teacher on Course.t_id=Teacher.t_id
go
select * from vw_GradeToUpload
select * from vw_GradeToUpload order by t_name

--���ڱ�����ֵ
declare @name nvarchar(50) = '����'
--declare @name varchar(50) = stu_name from Student where age = 15 --incorrect syntax
--set @name = (select stu_name from Student where age=7) --Mike ������subquery��һ��Ҫ��()
--select @name = (select stu_name from Student where age=7) --Mike
--set @name = stu_name from Student where age=7 --Incorrect syntax near the keyword 'from'.
--select @name = stu_name from Student where age=7 --Mike
--set @name = (select stu_name from Student) 
/*Subquery returned more than 1 value. 
This is not permitted when the subquery follows =, !=, <, <= , >, >= or 
when the subquery is used as an expression.*/
--select @name = (select stu_name from Student) --same as above
--select @name =  stu_name from Student --Brown(last value)
--set @name = (select stu_name from Student where stu_id=1000) --����
--select @name = (select stu_name from Student where stu_id=1000) --����
select @name = stu_name from Student where stu_id=1000 --Amy
print @name+'123'
go

--transaction��ϰ
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

--stored procedure��ϰ
exec sp_help Student
--��ѯ����ĳ�ſγ̿��Ե���Ů�����͸��Ե�ƽ����
/*
 _  _ _
|��|_|_|
|Ů|_|_|
*/
if exists (select * from sysobjects where name ='usp_GradeBySex')
drop proc usp_GradeBySex
go

create proc usp_GradeBySex
@cid int = 1
as
select gender, ��Ů����=count(*), ƽ����=avg(score) from (select * from Grade where c_id=@cid) as temp join Student
on temp.stu_id = Student.stu_id group by gender
go
exec usp_GradeBySex @cid=6

--����ĳλ��ʦ�̵���ĳ�ſγ̵�ѧ��������ƽ����
--����ͬʱ������������ֵ����ʹ����ʹ�õ���ͬһ�ű�
if exists (select * from sysobjects where name ='usp_GradeByTeacher')
drop proc usp_GradeByTeacher
go

create proc usp_GradeByTeacher
@stu_num int output,
@avg int output,
@tid int = 1,
@cid int=1
as
--��select֧��һ��Ϊ���������ֵ
select @stu_num = count(*), @avg=avg(score) from (select * from Teacher where t_id=@tid) as temp_teacher join 
(select * from Course where c_id=@cid) as temp_course
on temp_teacher.t_id=temp_course.t_id join Grade 
on temp_course.c_id=Grade.c_id
--select @avg = avg(score) from (select * from Teacher where t_id=@tid) as temp_teacher join 
--(select * from Course where c_id=@cid) as temp_course
--on temp_teacher.t_id=temp_course.t_id join Grade 
--on temp_course.c_id=Grade.c_id
go
declare @stu_num int, @avg int --д��һ����Ҫ�Ӷ��ţ�д������declare�ﲻ��Ҫ�Ӷ���

exec usp_GradeByTeacher @stu_num = @stu_num output, @avg = @avg output, @tid=4, @cid=2 --���յı���������Ӱ����
print @stu_num
print @avg
print 'Over'

--Trigger
--��Student��stu_name�ֶ����unique��constraint������with nocheck
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
print '�����ظ�ֵ'
delete from Student where stu_name = @name and stu_id=@max_id
end
else
print '����ɹ�'
end
go
insert into Student values ('Kevin','��',30,'1980-2-1')

--index 
--�ۼ��������Խ��ڱ��������,Ҳ���Խ�����������;
--һ������Խ��������,��ֻ����һ���ۼ�����,���������������ǷǾۼ�����;
--���ڵ�1����Ҫ˵������,Ĭ�������,����������ʱ,���û����ȷָ������Ϊ�Ǿۼ�ѡ��,���ұ��в����ھۼ�����,��ôϵͳ��Ϊ���������ۼ�����.
if exists (select * from sysindexes where name = 'IX_student_name') --sysindexes
drop index Student.IX_student_name
go
create unique index  IX_student_name on Student(stu_name) --���ܼ�cluster

--��ʱ��
create table #tempstudent(
 --stu_id int,
 stu_name varchar(50),
 gender nchar(1),
 age int,
 birthday datetime
)
select * into #newtemp from Student
select * from #newtemp

--�����ѯ�����ǲ�����ԭ��
select *, ����='sb' from Student

--һЩȫ�ֱ���
select @@SERVICENAME 'Service Name',  @@FETCH_STATUS 'Fetch Status', @@SERVERNAME 'Server Name'
select * from Student
print 'Ӱ����' + cast(@@ROWCOUNT as varchar(20)) + '��'

--һЩϵͳproc
exec sp_tables

--if����ж�
if (select count(*) from Student where stu_id=4)>0
select * from Student

--�����ظ�ֵ
select * from Grade where score in (select score from Grade group by score having (1<count(*)))

--��10������11
--��Ϊtop�����ִ�еģ��Ѿ�ѡ���˽���������ѡ��������ǰ10�����
select top 10 * from Teacher where t_id not in (select top 9 t_id from Teacher order by t_id asc) order by t_id asc 
select top 10 * from (select top 19 * from Teacher order by t_id asc) T order by t_id desc 
--ע�⣺���ʹ�������кŵĽ������Ϊ�Ӳ�ѯ����ô����Ϊ�������������ͬʱΪ�к��������
select * from (select ROW_NUMBER() over(order by t_id) id, * from Teacher) temp where id between 10 and 19

--ANY, ALL, INTERSECT, UNION, EXCEPT, ��all�ᱣ���ظ�ֵ
if 3>all(select score from Grade)
	print '����3������'
else
	print '�п�3�����µ�ѧ��'

select * from Student 
union
select 2, 'Rick', '��', 10, '2005-4-5'
print @@FETCH_STATUS

--˵�������������� TableA �е����� TableB��TableC �е��в����������ظ��ж�������һ�������  
(select stu_name from Student ) except (select stu_name from new_table) except (select stu_name from new_table2)  

--���Ʊ�ͷ
--1=1��1=2��ʹ�ã���SQL������ʱ�õĽ϶� 'where 1=1'�Ǳ�ʾѡ��ȫ�� 'where 1=2'ȫ����ѡ
select * into new_table from Student where 1<>1 --����һ
select top 0 * into new_table2 from Student --������
--�����ݿ�֮���Ŀ���(��������ʹ�þ���·��)
insert into Student(stu_name,gender,age, birthday) select 'Leo','��',15,'2014-3-1'

--�޸��ֶε���������
alter table Teacher alter column[experience] int

-- �����ݿⶨλ����
--Sqlserverд��������.dbo.���� �����ߣ�����..����(ע���м�ʹ�������㣩
select stu_id from test..Student
--��ѯָ�����е����б�
select * from [test].[dbo].[sysobjects] where [type] = 'U'
--�鿴��ǰ���ݿ������д洢����
select name as �洢�������� from sysobjects where type='P'  
--�г���������е��ֶ�
select name from syscolumns where id=object_id('Grade')
--��ѯĳһ������ֶκ���������  
select column_name,data_type from information_schema.columns where table_name = 'Teacher'  
--�鿴��ĳһ������ص���ͼ���洢���̡�����  
select a.* from sysobjects a, syscomments b where a.id = b.id and b.text like '%Student%'  

--���ȡ��10������
select top 10 * from Student order by newid()

--ʹ��SQL��� �á�����������ַ�����ʾ
select iif(len(stu_name)>2, left(stu_name, 2)+'...', stu_name) from Student

--ʹ���صĽ���в������й��� Transact-SQL ���Ӱ�����������Ϣ������洢�����а�����һЩ��䲢���������ʵ�ʵ����ݣ�����������ڴ���������������������˿�����������ܡ�SET NOCOUNT ��������ִ�л�����ʱ���ã��������ڷ���ʱ���á�  
--SET NOCOUNT Ϊ ON ʱ�������ؼ�������ʾ�� Transact-SQL ���Ӱ�����������  
--SET NOCOUNT Ϊ OFF ʱ�����ؼ���  
set nocount off

/*û�ù�����֪���ò�����
--��ѯ�û��������������ݿ�  
select * from master..sysdatabases D where sid not in(select sid from master..syslogins where name='sa')  
--����  
select dbid, name AS DB_NAME from master..sysdatabases where sid <> 0x01  
--�ж��Ƿ����ĳ�����ݿ⣬�����ڣ���ɾ��
if DB_ID('test') IS NOT NULL drop database test
--��sqlserver���ݿ�����ʹ���У�ɾ��֮ǰ����Ҫ�����ݿ���'��һ�û�'����ɾ��
ALTER DATABASE users SET SINGLE_USER with ROLLBACK IMMEDIATE IF DB_ID('users') IS NOT NULL DROP DATABASE users
--���� �������ݵ� device  
USE master
EXEC sp_addumpdevice 'disk', 'testBack', 'c:\mssql7backup\MyNwind_1.dat' 
--��ʼ ����  
BACKUP DATABASE pubs TO testBack  
--�����ݿ���в�����  
�������ݿ⣺ sp_detach_db; �������ݿ⣺sp_attach_db ��ӱ�����������Ҫ������·����  
--����޸����ݿ������:  
sp_renamedb 'old_name', 'new_name'  
--�ؽ�����  
DBCC REINDEX  
DBCC INDEXDEFRAG  
--�������ݺ���־  
DBCC SHRINKDB  
DBCC SHRINKFILE  
--ѹ�����ݿ�  
DBCC shrinkdatabase(dbname)  
--ת�����ݿ�����û����Ѵ����û�Ȩ��  
exec sp_change_users_login 'update_one','newname','oldname'  
go  
--��鱸�ݼ�  
RESTORE VERIFYONLY from disk='E:\dvbbs.bak'  
--�޸����ݿ�  
ALTER DATABASE [dvbbs] SET SINGLE_USER  
GO  
DBCC CHECKDB('dvbbs',repair_allow_data_loss) WITH TABLOCK  
GO  
ALTER DATABASE [dvbbs] SET MULTI_USER  
GO  
--�鿴Ӳ�̷���:  
EXEC master..xp_fixeddrives 
--�Ƚ�A,B���Ƿ����
if (select checksum_agg(binary_checksum(*)) from Student)  
= (select checksum_agg(binary_checksum(*)) from Teacher)  
print '���'  
else  
print '�����'  
*/

--�������ӷ�����  
exec sp_addlinkedserver 'ITSV ', ' ', 'SQLOLEDB ', 'Զ�̷���������ip��ַ '  
exec sp_addlinkedsrvlogin 'ITSV ', 'false ',null, '�û��� ', '���� '  
--��ѯʾ��  
select * from ITSV.���ݿ���.dbo.����  
--����ʾ��  
select * into �� from ITSV.���ݿ���.dbo.����  
--�Ժ���ʹ��ʱɾ�����ӷ�����  
exec sp_dropserver 'ITSV ', 'droplogins '  
--����Զ��/����������(openrowset/openquery/opendatasource)  
--1��openrowset  
--��ѯʾ��  
select * from openrowset( 'SQLOLEDB ', 'sql�������� '; '�û��� '; '���� ',���ݿ���.dbo.����)  
--���ɱ��ر�  
select * into �� from openrowset( 'SQLOLEDB ', 'sql�������� '; '�û��� '; '���� ',���ݿ���.dbo.����)  
--�ѱ��ر���Զ�̱�  
insert openrowset( 'SQLOLEDB ', 'sql�������� '; '�û��� '; '���� ',���ݿ���.dbo.����) select *from ���ر�  
--���±��ر�  
update b set b.��A=a.��A from openrowset( 'SQLOLEDB ', 'sql�������� '; '�û��� '; '���� ',���ݿ���.dbo.����)as a inner join ���ر� b   
on a.column1=b.column1  
--openquery�÷���Ҫ����һ������  
--���ȴ���һ�����Ӵ������ӷ�����  
exec sp_addlinkedserver 'ITSV ', ' ', 'SQLOLEDB ', 'Զ�̷���������ip��ַ '  
--��ѯ  
select * FROM openquery(ITSV, 'SELECT * FROM ���ݿ�.dbo.���� ')  
--�ѱ��ر���Զ�̱�  
insert openquery(ITSV, 'SELECT * FROM ���ݿ�.dbo.���� ')  
select * from ���ر�  
--���±��ر�  
update b set b.��B=a.��B FROM openquery(ITSV, 'SELECT * FROM ���ݿ�.dbo.���� ') as a inner join ���ر� b on a.��A=b.��A  
--3��opendatasource/openrowset  
SELECT * ROM opendatasource( 'SQLOLEDB ', 'Data Source=ip/ServerName;User ID=��½��;Password=���� ' ).test.dbo.roy_ta  
--�ѱ��ر���Զ�̱�  
insert opendatasource( 'SQLOLEDB ', 'Data Source=ip/ServerName;User ID=��½��;Password=���� ').���ݿ�.dbo.����  
select * from ���ر�