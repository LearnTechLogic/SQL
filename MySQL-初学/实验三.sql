use StuDB

SELECT S.Sno, S.Sname
FROM S, Dept
WHERE S.Deptno = Dept.Deptno AND Dept.Deptname = '计算机系';

SELECT Sno, Sname, Gender
FROM S
WHERE YEAR(Sdate) = 2005;

SELECT S.Sno, S.Sname, C.Cname, SC.Grade
FROM S, C, SC
WHERE S.Sno = SC.Sno AND C.Cno = SC.Cno AND SC.Grade < 80
ORDER BY S.Sno ASC, SC.Grade DESC;

SELECT Sno, Cno
FROM SC
WHERE Grade IS NULL;

SELECT Cno, COUNT(Sno) AS StudentCount, AVG(Grade) AS AverageGrade, MAX(Grade) AS MaxGrade, MIN(Grade) AS MinGrade, SUM(Grade) AS TotalGrade
FROM SC
GROUP BY Cno;

SELECT Sno
FROM SC
GROUP BY Sno
HAVING COUNT(Cno) > 1;

SELECT *
FROM S
WHERE Sname LIKE '张%';

SELECT C2.Cpno
FROM C AS C1, C AS C2
WHERE C1.Cpno = C2.Cno;

SELECT S.Sno, S.Sname
FROM S, C, SC
WHERE S.Sno = SC.Sno AND C.Cno = SC.Cno AND C.Cname = '数据库原理' AND SC.Grade > 70;

SELECT S.Sno, S.Sname
FROM S
WHERE S.Sno IN (
    SELECT SC.Sno
    FROM SC, C
    WHERE SC.Cno = C.Cno AND C.Cname = '数据库原理' AND SC.Grade > 70
);

SELECT S.Sno, S.Sname
FROM S
WHERE S.Deptno = (SELECT Deptno FROM Dept WHERE Deptname = '计算机系')
AND S.Sno NOT IN (SELECT Sno FROM SC WHERE Cno = 7);

SELECT Cname
FROM C
WHERE Cno IN (
    SELECT Cno
    FROM SC
    GROUP BY Cno
    HAVING COUNT(Sno) = (SELECT COUNT(*) FROM S)
);

SELECT DISTINCT S.Sno, S.Sname
FROM S, SC AS SC1
WHERE S.Sno = SC1.Sno AND NOT EXISTS (
    SELECT *
    FROM SC AS SC2
    WHERE SC2.Sno = (SELECT Sno FROM S WHERE Sname = '张征') AND SC2.Cno NOT IN (
        SELECT SC3.Cno
        FROM SC AS SC3
        WHERE SC3.Sno = SC1.Sno
    )
);

SELECT Cname, Credit
FROM C
WHERE Credit > 4
UNION
SELECT Cname, Credit
FROM C
WHERE Credit = 3;

SELECT S.Sname, S.Sdate
FROM S, Dept
WHERE S.Deptno = Dept.Deptno AND Dept.Deptname = '计算机系'
AND S.Sdate < ALL (
    SELECT S2.Sdate
    FROM S AS S2, Dept AS Dept1
    WHERE S2.Deptno = Dept1.Deptno AND Dept1.Deptname='质量系'
);

SELECT S.Sname, SC.Grade
FROM S, SC, C, Dept
WHERE S.Sno = SC.Sno AND SC.Cno = C.Cno AND S.Deptno = Dept.Deptno
AND Dept.Deptname = '计算机系' AND C.Cname = '数据库原理';

SELECT TOP 1 SC.Sno, SC.Grade
FROM SC, C
WHERE SC.Cno = C.Cno AND C.Cname = '计算机基础'
ORDER BY SC.Grade DESC

