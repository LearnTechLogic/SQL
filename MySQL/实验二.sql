use StuDB
create table S1(
	Sno int not null,
	Sname varchar(30) not null,
	Gender char(2) default'男',
	Sdate date,
	Deptno int,
	primary key(Sno),
	foreign key(Deptno) references Dept(Deptno)
);

drop table S1;

insert into S (Sno,Sname,Gender,Sdate,Deptno)
values(227401,'张小红','女','2005-09-21',7);

insert into SC(Sno,Cno,Grade) 
values (221401,8,100);

insert into C(Cno,Cname)
values (8,'标注日语');
insert into SC(Sno,Cno,Grade)
values(221401,8,100);

insert into SC(Sno,Cno) 
values(227401,7);

update S set Sdate='2005-09-28' where Sno=227401;

delete from SC where Sno=227401;
delete from S where Sno=227401;

delete from SC where Cno= (select cno from C where Cname='数据库原理');
delete from C where Cname='数据库原理';

create view ComputerStudentsGrade as
select S.Sno,S.Sname,AVG(SC.Grade) AS AVGGrade
from S
join SC on S.Sno=SC.Sno
join C on SC.Cno=C.Cno
where S.Deptno=(select Deptno from Dept where Deptname='计算机系')
group by S.Sno,S.Sname;

select C.Cno,C.Cpno,Cp.Cname
from C
left join C Cp on C.Cpno=Cp.Cno;

select * 
from S 
where YEAR(Sdate) in (2004,2005);

select *
from SC
where Grade>=80;

select *
from S
where Gender = '女';

select SC.Sno,SC.Cno,C.Cname
from SC
join C on SC.Cno=C.Cno
join S on S.Sno=SC.Sno
join Dept on Dept.Deptno=S.Deptno
where Deptname='计算机系';

delete from S where Deptno=1;

delete from SC where Sno in(select Sno from S where Deptno=1);
delete from S where Deptno=1;
