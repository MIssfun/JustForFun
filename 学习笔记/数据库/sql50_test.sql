-- ��ṹ
-- fy_student(sno,sname,sage,ssex) ѧ����
-- course(cno,cname,tno) �γ̱�
-- sc(sno,cno,score) �ɼ���
-- fy_teacher(tno,tname) ��ʦ��


--1����ѯ�γ�1�ĳɼ� �� �γ�2�ĳɼ� �� ������ѧ����ѧ��.
select  a.sno from 
(select c1.sno,c1.score from sc c1 where c1.cno=1) a ,
(select c2.sno,c2.score from sc c2 where c2.cno=2) b 
where a.score>b.score and a.sno=b.sno;

--2����ѯƽ���ɼ�����60�ֵ�ͬѧ��ѧ�ź�ƽ���ɼ���
select sno,avg(score) from sc 
group by sno 
having avg(score)>60 
order by avg(score) desc;

--3����ѯ����ͬѧ��ѧ�š�������ѡ�������ܳɼ�
select s1.sno,s2.sname,count(*),sum(s1.score) from
sc s1 inner join fy_student s2 on s1.sno=s2.sno
group by s2.sname,s1.sno
order by sum(s1.score) desc;

--4����ѯ�ա������ʦ�ĸ�����
select count(*) from fy_teacher where tname like '��%';

--5����ѯûѧ����Ҷƽ����ʦ�ε�ͬѧ��ѧ�š�������
select sno,sname from fy_student
where sno not in (
select distinct(s1.sno) 
from sc s1,course c1,fy_teacher t1
where s1.cno=c1.cno and c1.tno=t1.tno and t1.tname='Ҷƽ');

--6����ѯͬʱѧ���γ�1�Ϳγ�2��ͬѧ��ѧ�š�����
select sno,sname from fy_student
where sno in (
select sno from sc where sc.cno=1) and
sno in (select sno from sc where sc.cno=2);

--7����ѯѧ����Ҷƽ����ʦ�������пγ̵�����ͬѧ��ѧ�š�����
select sno,sname from fy_student
where sno  in (
select s1.sno 
from sc s1,course c1,fy_teacher t1
where s1.cno=c1.cno and c1.tno=t1.tno and t1.tname='Ҷƽ');

--8����ѯ �γ̱��1�ĳɼ� �� �γ̱��2�ĳɼ� �ߵ�����ͬѧ��ѧ�š�����
select sno,sname from fy_student
where sno in (
select a.sno from
(select sno ,score from sc where cno=1) a,
(select sno ,score from sc where cno=2) b
where a.sno=b.sno and a.score>b.score
);

--9����ѯ���пγ̳ɼ�С��60�ֵ�ͬѧ��ѧ�š�����
select sno,sname from fy_student
where sno not in (
select distinct sno from sc where score>60
);

--10����ѯ���пγ̳ɼ�����60�ֵ�ͬѧ��ѧ�š�����
select sno,sname from fy_student
where sno not in (
select distinct sno from sc where score<60
);

--11����ѯû��ѧȫ���пε�ͬѧ��ѧ�š�����
select sno,sname from fy_student
where sno not in (
select distinct sno from sc 
group by sno 
having count(*) =(select count(distinct cno) from sc)
);

--12����ѯ������һ�ſγ� �� ѧ��Ϊ1��ͬѧ��ѧ�γ� ��ͬ��ͬѧ��ѧ�ź�����
select sno ,sname from fy_student
where sno<>1 and sno  in(
	select sno from sc where cno  in (
		select distinct cno from sc where sno=1
	)
);

--13���ѡ�sc�����С�Ҷƽ�����̿εĳɼ�������Ϊ�˿γ̵�ƽ���ɼ�
update sc set score=(select avg(sc_2.score) from sc sc_2 where sc_2.cno=sc.cno)
where sc.cno in (select course.cno from fy_teacher,course where fy_teacher.tno=course.tno  and fy_teacher.tname='Ҷƽ');

--14����ѯ��2��ͬѧѧϰ�Ŀγ���ȫ��ͬ������ͬѧѧ�ź�����
select sno,sname from fy_student
where sno in (select sno from sc 
where sno <>2
group by sno
having sum(cno)=(select sum(cno) from sc where sno=2));

--15��ɾ��ѧϰ��Ҷƽ����ʦ�ε�sc���¼
delete from sc where cno in (
	select a.cno from course a,fy_teacher b where a.tno=b.tno and b.tname='Ҷƽ' 
);

--16����sc���в���һЩ��¼����Щ��¼Ҫ���������������
--��û�пγ�3�ɼ�ͬѧ�ĸóɼ�����, ��ɼ�ȡ����ѧ���Ŀγ�2��ƽ���ɼ�
insert into sc select sno,3,(select avg(score) from sc where cno=2) 
	from fy_student where sno not in
	(select sno from sc where cno =3);

--17����ƽƽ���ִӸߵ�����ʾ����ѧ��������ͳ�Ʊ���
-- ѧ��,��ҵ����,���˼,UML,���ݿ�,����,�γ���, ƽ����

select sno as ѧ��,
max(case when cno=1 then score end) as ��ҵ����,
max(case when cno=2 then score end) as ���˼,
max(case when cno=3 then score end) as UML,
max(case when cno=4 then score end) as ���ݿ�,
max(case when cno=5 then score end) as ����,
count(*) as �γ���,
avg(score) as ƽ����
from sc 
group by sno
order by ƽ����;

--18����ѯ���Ƴɼ���߷ֺ���ͷ֣���������ʽ��ʾ���γ̺ţ���߷֣���ͷ�
select cno as �γ̺�,
max(score) as ��߷�,
min(score) as ��ͷ�
from sc
group by cno;

--19��������ƽ���ɼ��ӵ͵��ߺͼ����ʵİٷ����Ӹߵ���˳��
select t.cno as �γ̺�,
max(course.cname)as �γ���,
nvl(avg(score),0) as ƽ���ɼ�,
100 * sum(case when nvl(score,0)>=60 then 1 else 0 end)/count(1) as ������
from sc t, course
where t.cno = course.cno
group by t.cno
group by ƽ���ɼ� asc,������;

--20����ѯ���¿γ�ƽ���ɼ��ͼ����ʵİٷ���(��"1��"��ʾ): ��ҵ����001�������˼��002����UML ��003�������ݿ⣨004�� 
select avg (case when cno=1 then score end) as ƽ����1,
avg (case when cno=2 then score end) as ƽ����2,
avg (case when cno=3 then score end) as ƽ����3,
avg (case when cno=4 then score end) as ƽ����4,
100*sum(case when nvl(score,0)>=60 and cno=1 then 1 else 0 end)/count(1) as ������1,
100*sum(case when nvl(score,0)>=60 and cno=2 then 1 else 0 end)/count(1) as ������2,
100*sum(case when nvl(score,0)>=60 and cno=3 then 1 else 0 end)/count(1) as ������3,
100*sum(case when nvl(score,0)>=60 and cno=4 then 1 else 0 end)/count(1) as ������4
from sc;

--21����ѯ��ͬ��ʦ���̲�ͬ�γ�ƽ����, �Ӹߵ�����ʾ
-- ����ʦ ���ݿ� 88
select t.tname,a.cname,avg(sc.score)
from fy_teacher t,course a,sc
where t.tno=a.tno and a.cno=sc.cno
group by a.cname,t.tname
order by avg(sc.score) desc;

--22����ѯ���¿γ̳ɼ����ڵ�3������6��֮���ѧ���ĳɼ���
-- [ѧ��ID],[ѧ������],��ҵ����,���˼,UML,���ݿ�,ƽ���ɼ�
select stu.sno as ѧ��ID,
stu.sname as ѧ������,
max(case when sc.cno=1 then score end) as ��ҵ����,
max(case when sc.cno=2 then score end) as ���˼,
max(case when sc.cno=3 then score end) as UML,
max(case when sc.cno=4 then score end) as ���ݿ�,
avg(score) as ƽ���ɼ�
from fy_student stu,sc
where stu.sno=sc.sno and
stu.sno in (select * from (select sno from sc where cno=1 order by score desc) where rownum <7) and
stu.sno not in (select * from (select sno from sc where cno=1 order by score desc) where rownum <3) and
stu.sno in (select * from (select sno from sc where cno=2 order by score desc) where rownum <7) and
stu.sno not in (select * from (select sno from sc where cno=2 order by score desc) where rownum <3) and
stu.sno in (select * from (select sno from sc where cno=3 order by score desc) where rownum <7) and
stu.sno in (select * from (select sno from sc where cno=4 order by score desc) where rownum <7) and
stu.sno not in (select * from (select sno from sc where cno=4 order by score desc) where rownum <3)
group by stu.sname ,stu.sno;

--23��ͳ�ƴ�ӡ���Ƴɼ�,������������:�γ�ID,�γ�����,[100-85],[85-70],[70-60],[ <60]
select sc.cno as �γ�ID,
b.cname as �γ�����,
sum(case when sc.score>=85 and sc.score<=100 then 1 else 0 end) as ��100��85�� 
sum(case when sc.score>=70 and sc.score<85 then 1 else 0 end) as ��85��70, 
sum(case when sc.score>=60 and sc.score<70 then 1 else 0 end) as ��70��60, 
sum(case when sc.score<60 then 1 else 0 end) as С��60
from sc,course b
where sc.cno=b.cno
group by b.cname,sc.cno;

--24����ѯѧ��ƽ���ּ�������
select sno as ѧ�����,
score_avg as ƽ����,
rownum as ���� from
(select sno,avg(score) as score_avg from sc
group by sno
order by score_avg desc);

--25����ѯ�γ�2�ɼ�ǰ�����ļ�¼:(�����ǳɼ��������) 
select * from (
select * from sc order by score desc
)where rownum<4 and cno=2;

--26����ѯÿ�ſγ̱�ѡ�޵�ѧ���� 
select cno,count(*) from sc group by cno order by count(*);

--27����ѯ��ֻѡ����һ�ſγ̵�ȫ��ѧ����ѧ�ź����� 
select a.sno ,a.sname
from fy_student a,sc
where a.sno=sc.sno
group by a.sname,a.sno
having count(*)=7;

--28����ѯ������Ů������ 
select sum(case when ssex='��' then 1 else 0 end) as ��������,
sum(case when ssex='Ů' then 1 else 0 end) as Ů������
from fy_student;

--29����ѯ�ա��š���ѧ������ 
select * from fy_student where sname like '��%';

--30����ѯͬ��ͬ��ѧ����������ͳ��ͬ������
select sname,ssex from fy_student
group by sname,ssex
having count(*)>1;

--31��1981�������ѧ������(ע��student����sage�е�������date) 
--�����ַ�����ʽ�Ƚ�����
select * from fy_student
where to_char(sage) like '%81';

--32����ѯÿ�ſγ̵�ƽ���ɼ��������ƽ���ɼ��������У�ƽ���ɼ���ͬʱ�����γ̺Ž������� 
select cno,avg(score) from sc
group by cno
order by cno desc,avg(score) asc;

--33����ѯƽ���ɼ�����80������ѧ����ѧ�š�������ƽ���ɼ�
select a.sno,a.sname,avg(score)
from fy_student a,sc
where a.sno=sc.sno
group by a.sname,a.sno
having avg(score)>80;

--34����ѯ ���ݿ� ���� ����60��ѧ�������ͷ���
select a.sname,sc.score
from fy_student a,sc,course b
where a.sno=sc.sno and sc.cno=b.cno and cname='���ݿ�' and sc.score<60;

--35����ѯ����ѧ����ѡ�����
select a.sno, a.sname,count(sc.cno)
from fy_student a left join sc on a.sno=sc.sno
group by a.sname,a.sno;

--36����ѯ�ɼ���70�����ϵ�ѧ���������γ����ƺͷ���
select a.sname,b.cname,sc.score from
fy_student a,course b, sc
where a.sno=sc.sno and b.cno=sc.sno and sc.score>70;

--37����ѯ�в�����ɼ��Ŀγ̣������γ̺ŴӴ�С����
select distinct cno from sc
where score<60
order by cno desc;

--38����ѯ�γ̱��Ϊ3�ҿγ̳ɼ���80�����ϵ�ѧ����ѧ�ź�����
select a.sno ,a.sname
from fy_student a,sc
where a.sno=sc.sno and cno=3 and sc.score>80;

--39����ѡ�˿γ̵�ѧ������ 
select count(distinct(a.sno))
from fy_student a inner join sc on a.sno=sc.sno;

--40����ѯѡ�ޡ�Ҷƽ����ʦ���ڿγ̵�ѧ���У��ɼ���ߵ�ѧ����������ɼ� 
select a.sname ,sc.score
from fy_student a ,sc,fy_teacher b,course c
where sc.cno=c.cno and c.tno=b.tno and b.tname='Ҷƽ' and
score=(select max(score) from sc  d where d.cno=c.cno);

--41����ѯ�����γ̼���Ӧ��ѡ������ 
select c.cname,count(*)
from course c inner join sc on c.cno=sc.cno
group by c.cname;

--42����ѯ��ͬ�γ̳ɼ���ͬ��ѧ����ѧ�š��γ̺š�ѧ���ɼ�
--�Ա��ѯ 
select a.sno,a.cno,a.score from sc a,sc b where a.score=b.score and a.cno!=b.cno;

--43����ѯ�γ̱��Ϊ2�ɼ���õ�ǰ������ѧ��ID
select sno from (
select * from sc where cno=2 order by score)
where rownum<3;

--44��ͳ��ÿ�ſγ̵�ѧ��ѡ������(������2��ѡ�޵Ŀγ̲�ͳ��)��Ҫ������γ̺ź�ѡ��������
--��ѯ����������������У���������ͬ�����γ̺��������� 
select cno ,count(sno)
from sc
group by cno
having count(sno)>2;

--45����������ѡ����5�ſγ̵�ѧ��ѧ��
select sno,count(cno)
from sc
group by sno
having count(cno)>=5;

--46����ѯȫ��ѧ����ѡ�޵Ŀγ̵Ŀγ̺źͿγ���
select cno ,count(sno)
from sc
group by cno
having count(sno)=(select count(stu.sno) from fy_student stu);

--47����ѯûѧ����Ҷƽ����ʦ���ڵ���һ�ſγ̵�ѧ������
select sname from fy_student
where sno not in (
	select distinct sno from sc,course a,fy_teacher b
	where sc.cno=a.cno and a.tno=b.tno and b.tname='Ҷƽ'
);

--48����ѯ�������ϲ�����γ̵�ͬѧ��ѧ�ż���ƽ���ɼ�
select a.sno ,avg(a.score)
from sc a
where a.sno in (
	select sno
	from sc
	where score<60
	group by sno
	having count(sno)>=2)
group by a.sno;

--49������4�ſγ̷�������60��ͬѧѧ�ţ���������������
select sno,score
from sc
where cno=4 and score>=60
order by score desc;

--50��ɾ��2��ͬѧ�Ŀγ�1�ĳɼ�
delete from sc where sno=2 and cno=1;

/*
�ܽ᣺
1. oracleʹ��select * from ��SQL��where rownum<n������mysql�е�top n�÷���
2. group by������select�Ĳ���ͬ�����ۺϺ������⡣
3. ʹ�ã�case when ���� then ... else ... end)��ִ������������
4. ��%,_,&�ַ����ֶ���Ҫ��ת���ַ�������ת���ַ�set escape /��
5. oracleʹ��nvl(�ֶΣ������)������mysql�е�isnull(�ֶΣ������)����ʾ�����ֶ�Ϊ��ʱ�����������ʾ��
6. �Ӳ�ѯֻ��Ƕ����һ������ԡ�
*/