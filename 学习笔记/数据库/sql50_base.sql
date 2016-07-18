-- 1.������ѧϵͳ�����ݿ⣬���Լ�����
-- fy_student(sno,sname,sage,ssex) ѧ����
-- course(cno,cname,tno) �γ̱�
-- sc(sno,cno,score) �ɼ���
-- fy_teacher(tno,tname) ��ʦ��

drop table sc;
drop table course;
drop table fy_student;
drop table fy_teacher;


-- 2.������ʦ��
CREATE TABLE fy_teacher(
    tno number(3) NOT NULL PRIMARY KEY,
    tname varchar2(20) NOT NULL
);

-- ��ʦ������
INSERT INTO fy_teacher(tno,tname)VALUES(1,'����ʦ');
INSERT INTO fy_teacher(tno,tname)VALUES(2,'����ʦ');
INSERT INTO fy_teacher(tno,tname)VALUES(3,'����ʦ');
INSERT INTO fy_teacher(tno,tname)VALUES(4,'����ʦ');
INSERT INTO fy_teacher(tno,tname)VALUES(5,'����ʦ');
INSERT INTO fy_teacher(tno,tname)VALUES(6,'����ʦ');
INSERT INTO fy_teacher(tno,tname)VALUES(7,'���ľ�');
INSERT INTO fy_teacher(tno,tname)VALUES(8,'Ҷƽ');

-- 3.����ѧԱ��
CREATE TABLE fy_student(
    sno number NOT NULL PRIMARY KEY,
    sname varchar2(20) NOT NULL,
    sage date NOT NULL,
    ssex char(2) NOT NULL
);

-- ��������
INSERT INTO fy_student(sno,sname,sage,ssex) VALUES(1,'����',to_date('1980-1-23','YYYY-MM-DD'),'��');
INSERT INTO fy_student(sno,sname,sage,ssex) VALUES(2,'����',to_date('1982-12-12','YYYY-MM-DD'),'��');
INSERT INTO fy_student(sno,sname,sage,ssex) VALUES(3,'���',to_date('1981-9-9','YYYY-MM-DD'),'��');
INSERT INTO fy_student(sno,sname,sage,ssex) VALUES(4,'����',to_date('1983-3-23','YYYY-MM-DD'),'Ů');
INSERT INTO fy_student(sno,sname,sage,ssex) VALUES(5,'����',to_date('1982-6-21','YYYY-MM-DD'),'��');
INSERT INTO fy_student(sno,sname,sage,ssex) VALUES(6,'����',to_date('1984-10-10','YYYY-MM-DD'),'Ů');
INSERT INTO fy_student(sno,sname,sage,ssex) VALUES(7,'����',to_date('1980-12-22','YYYY-MM-DD'),'Ů');

-- 4.�����γ̱�
CREATE TABLE course(
    cno number NOT NULL PRIMARY KEY,
    cname varchar2(20) NOT NULL,
    tno number NOT NULL
);

-- 5.�������
ALTER TABLE course ADD
CONSTRAINT FK_course_fy_teacher FOREIGN KEY(tno)
REFERENCES fy_teacher(tno);

-- ��������
insert into course(cno,cname,tno) values(1,'��ҵ����',3);
insert into course(cno,cname,tno) values(2,'���˼',1);
insert into course(cno,cname,tno) values(3,'UML',2);
insert into course(cno,cname,tno) values(4,'���ݿ�',5);
insert into course(cno,cname,tno) values(5,'����',8);

-- 5.�����ɼ���
CREATE TABLE sc(
    sno number NOT NULL,
    cno number NOT NULL,
    score number NOT NULL
);

-- �������
ALTER TABLE sc ADD CONSTRAINT FK_sc_course FOREIGN KEY(cno)
REFERENCES course(cno);
ALTER TABLE sc ADD CONSTRAINT FK_sc_fy_student FOREIGN KEY(sno)
REFERENCES fy_student(sno);

-- ��������
INSERT INTO sc(sno,cno,score)VALUES(1,1,80);
INSERT INTO sc(sno,cno,score)VALUES(1,2,86);
INSERT INTO sc(sno,cno,score)VALUES(1,3,83);
INSERT INTO sc(sno,cno,score)VALUES(1,4,89);

INSERT INTO sc(sno,cno,score)VALUES(2,1,50);
INSERT INTO sc(sno,cno,score)VALUES(2,2,36);
INSERT INTO sc(sno,cno,score)VALUES(2,3,43);
INSERT INTO sc(sno,cno,score)VALUES(2,4,59);

INSERT INTO sc(sno,cno,score)VALUES(3,1,50);
INSERT INTO sc(sno,cno,score)VALUES(3,2,96);
INSERT INTO sc(sno,cno,score)VALUES(3,3,73);
INSERT INTO sc(sno,cno,score)VALUES(3,4,69);

INSERT INTO sc(sno,cno,score)VALUES(4,1,90);
INSERT INTO sc(sno,cno,score)VALUES(4,2,36);
INSERT INTO sc(sno,cno,score)VALUES(4,3,88);
INSERT INTO sc(sno,cno,score)VALUES(4,4,99);

INSERT INTO sc(sno,cno,score)VALUES(5,1,90);
INSERT INTO sc(sno,cno,score)VALUES(5,2,96);
INSERT INTO sc(sno,cno,score)VALUES(5,3,98);
INSERT INTO sc(sno,cno,score)VALUES(5,4,99);

INSERT INTO sc(sno,cno,score)VALUES(6,1,70);
INSERT INTO sc(sno,cno,score)VALUES(6,2,66);
INSERT INTO sc(sno,cno,score)VALUES(6,3,58);
INSERT INTO sc(sno,cno,score)VALUES(6,4,79);

INSERT INTO sc(sno,cno,score)VALUES(7,1,80);
INSERT INTO sc(sno,cno,score)VALUES(7,2,76);
INSERT INTO sc(sno,cno,score)VALUES(7,3,68);
INSERT INTO sc(sno,cno,score)VALUES(7,4,59);
INSERT INTO sc(sno,cno,score)VALUES(7,5,89);