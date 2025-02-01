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

create table shop(--商店
	sno int identity(1000000,1),
	sname varchar(30) not null,
	primary key(sno)
);

create table commodity(--商品
	cno int identity(10000000,1),-- 商品编号
	cname varchar(30) not null,-- 商品名
	cprice decimal(4,2),-- 商品价格
	cshop int,-- 店铺号
	primary key(cno),
	foreign key(cshop)references shop(sno)
);

create table members(--客户
	mno int identity(1000000000,1),
	mname varchar(30) not null,
	mintegral int,
	primary key(mno)
);

create table book(-- 购买信息
	bno int identity(100000000,1),-- 订单号
	bmno int not null,-- 客户账号
	btime date not null,-- 购买时间
	bshop int,-- 购买商店
	bway varchar(30),-- 付款方式
	bkind varchar(30),-- 币种
	primary key(bno),
	foreign key(bmno)references members(mno),
	foreign key(bshop)references shop(sno)
);

create table bookditail(-- 购买明细
	bno int identity(1,1),
	bdno int not null,-- 订单号
	bdcno int not null,-- 商品编号
	bdnumber int not null,-- 商品数量
	primary key(bno),
	foreign key(bdno)references book(bno),
	foreign key(bdcno)references commodity(cno)
);
-- 查询某日销售总额
SELECT SUM(bdnumber * cprice) AS TotalSales, btime
FROM bookditail
JOIN commodity ON bookditail.bdcno = commodity.cno
JOIN book ON bookditail.bdno = book.bno
WHERE CAST(btime AS DATE) = '2024-11-16'and book.bshop=1000000 -- 查询2024年11月16日的销售数据
GROUP BY btime;

--查询某月销售总额
SELECT SUM(bdnumber * cprice) AS TotalSales, YEAR(btime) AS SaleYear, MONTH(btime) AS SaleMonth
FROM bookditail
JOIN commodity ON bookditail.bdcno = commodity.cno
JOIN book ON bookditail.bdno = book.bno
WHERE YEAR(btime) = 2024 AND MONTH(btime) = 11 and book.bshop=1000000 -- 查询2024年11月的销售数据
GROUP BY YEAR(btime), MONTH(btime);

--查询某年的销售总额
SELECT SUM(bdnumber * cprice) AS TotalSales, YEAR(btime) AS SaleYear
FROM bookditail
JOIN commodity ON bookditail.bdcno = commodity.cno
JOIN book ON bookditail.bdno = book.bno
WHERE YEAR(btime) = 2024 and book.bshop=1000000 -- 查询2024年的销售数据
GROUP BY YEAR(btime);

-- 查询某客户某日的具体购物情况
SELECT members.mname, commodity.cname, bookditail.bdnumber, commodity.cprice, bookditail.bdnumber * commodity.cprice AS TotalPrice, book.btime
FROM bookditail
JOIN commodity ON bookditail.bdcno = commodity.cno
JOIN book ON bookditail.bdno = book.bno
JOIN members ON book.bmno = members.mno
WHERE members.mno = 1000000000 -- 查询会员编号为1000000000的顾客
AND CAST(btime AS DATE) = '2024-11-16' and book.bshop=1000000 -- 查询2024年11月16日的购买情况
ORDER BY book.btime;

