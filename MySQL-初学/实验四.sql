create database StuMA;
use StuMA;

create table way(
	wnumber int,
	wname varchar(30)
);

create table kind(
	knumber int,
	kname varchar(30)
);

create table shop(--�̵�
	sno int identity(1000000,1),
	sname varchar(30) not null,
	primary key(sno)
);

create table commodity(--��Ʒ
	cno int identity(10000000,1),-- ��Ʒ���
	cname varchar(30) not null,-- ��Ʒ��
	cprice decimal(4,2),-- ��Ʒ�۸�
	cshop int,-- ���̺�
	primary key(cno),
	foreign key(cshop)references shop(sno)
);

create table members(--�ͻ�
	mno int identity(1000000000,1),
	mname varchar(30) not null,
	mintegral int,
	primary key(mno)
);

create table book(-- ������Ϣ
	bno int identity(100000000,1),-- ������
	bmno int not null,-- �ͻ��˺�
	btime date not null,-- ����ʱ��
	bshop int,-- �����̵�
	bway varchar(30),-- ���ʽ
	bkind varchar(30),-- ����
	primary key(bno),
	foreign key(bmno)references members(mno),
	foreign key(bshop)references shop(sno)
);

create table bookditail(-- ������ϸ
	bno int identity(1,1),
	bdno int not null,-- ������
	bdcno int not null,-- ��Ʒ���
	bdnumber int not null,-- ��Ʒ����
	primary key(bno),
	foreign key(bdno)references book(bno),
	foreign key(bdcno)references commodity(cno)
);
-- ��ѯĳ�������ܶ�
SELECT SUM(bdnumber * cprice) AS TotalSales, btime
FROM bookditail
JOIN commodity ON bookditail.bdcno = commodity.cno
JOIN book ON bookditail.bdno = book.bno
WHERE CAST(btime AS DATE) = '2024-11-16'and book.bshop=1000000 -- ��ѯ2024��11��16�յ���������
GROUP BY btime;

--��ѯĳ�������ܶ�
SELECT SUM(bdnumber * cprice) AS TotalSales, YEAR(btime) AS SaleYear, MONTH(btime) AS SaleMonth
FROM bookditail
JOIN commodity ON bookditail.bdcno = commodity.cno
JOIN book ON bookditail.bdno = book.bno
WHERE YEAR(btime) = 2024 AND MONTH(btime) = 11 and book.bshop=1000000 -- ��ѯ2024��11�µ���������
GROUP BY YEAR(btime), MONTH(btime);

--��ѯĳ��������ܶ�
SELECT SUM(bdnumber * cprice) AS TotalSales, YEAR(btime) AS SaleYear
FROM bookditail
JOIN commodity ON bookditail.bdcno = commodity.cno
JOIN book ON bookditail.bdno = book.bno
WHERE YEAR(btime) = 2024 and book.bshop=1000000 -- ��ѯ2024�����������
GROUP BY YEAR(btime);

-- ��ѯĳ�ͻ�ĳ�յľ��幺�����
SELECT members.mname, commodity.cname, bookditail.bdnumber, commodity.cprice, bookditail.bdnumber * commodity.cprice AS TotalPrice, book.btime
FROM bookditail
JOIN commodity ON bookditail.bdcno = commodity.cno
JOIN book ON bookditail.bdno = book.bno
JOIN members ON book.bmno = members.mno
WHERE members.mno = 1000000000 -- ��ѯ��Ա���Ϊ1000000000�Ĺ˿�
AND CAST(btime AS DATE) = '2024-11-16' and book.bshop=1000000 -- ��ѯ2024��11��16�յĹ������
ORDER BY book.btime;

