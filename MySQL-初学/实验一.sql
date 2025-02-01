create database StuDB;
use StuDB
create table Dept(
	Deptno int not null,
	Deptname varchar(30) not null,
	Mastername varchar(30),
	primary key (Deptno)
);
create table S(
	Sno int not null,
	Sname varchar(30) not null,
	Gender char(2) default'男',
	Sdate date,
	Deptno int,
	primary key(Sno),
	foreign key(Deptno) references Dept(Deptno)
);
create table C(
	Cno int not null,
	Cname varchar(30) not null,
	Cpno int,
	Credit decimal(3,1),
	primary key(Cno),
	foreign key(Cpno) references C(Cno)
);
create table SC(
	Sno int not null,
	Cno int not null,
	Grade decimal(4,1),
	primary key(Sno,Cno),
	foreign key(Sno) references S(Sno),
	foreign key(Cno) references C(Cno)
);

create login User1 with password='1234',default_database=[master],default_language=[简体中文],check_expiration=off,check_policy=off
create user User1 for login User1 with default_schema=[dbo]

grant select on S to User1;
grant update(cname) on C to User1;

select * from S;

UPDATE C SET Cname = '数据库基础' WHERE Cno = 7;

create login zhaoxinhang with password='1234',default_database=[master],default_language=[简体中文],check_expiration=off,check_policy=off
create user zhaoxinhang for login zhaoxinhang with default_schema=[dbo]
grant Select on S to zhaoxinhang;
grant update(Sname) on S to zhaoxinhang with grant option;
grant update(Sname) on S to User1;

select * from S;

UPDATE S SET Sname = '王三' WHERE Sno = 225401;

revoke update(Sname) on S from User1;
revoke update(Sname) on S to zhaoxinhang cascade;
revoke select on s from zhaoxinhang;


create view ComputerStudent AS
SELECT S.Sno,S.Sname,S.Gender,S.Sdate,S.Deptno
from S,Dept
WHERE S.Deptno=Dept.Deptno and Dept.Deptname='计算机系';

grant select on ComputerStudent to zhaoxinhang;

SELECT * FROM ComputerStudent