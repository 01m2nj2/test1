/**********************************/
/* Table Name: ������ */
/**********************************/
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE admin;

CREATE TABLE admin(
    adminno    NUMBER(10)    NOT NULL,
    id         VARCHAR(20)   NOT NULL UNIQUE, -- ���̵�, �ߺ� �ȵ�, ���ڵ带 ���� 
    passwd     VARCHAR(15)   NOT NULL, -- �н�����, ������ ����
    mname      VARCHAR(20)   NOT NULL, -- ����, �ѱ� 10�� ���� ����
    mdate      DATE          NOT NULL, -- ������    
    grade      NUMBER(2)     NOT NULL, -- ���(1~10: ������, 11~20: ȸ��, ��ȸ��: 30~39, ���� ȸ��: 40~49, Ż�� ȸ��: 99)    
    PRIMARY KEY (adminno)              -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);

COMMENT ON TABLE admin is '������';
COMMENT ON COLUMN admin.adminno is '������ ��ȣ';
COMMENT ON COLUMN admin.id is '���̵�';
COMMENT ON COLUMN admin.PASSWD is '�н�����';
COMMENT ON COLUMN admin.MNAME is '����';
COMMENT ON COLUMN admin.MDATE is '������';
COMMENT ON COLUMN admin.GRADE is '���';

DROP SEQUENCE admin_seq;

CREATE SEQUENCE admin_seq
  START WITH 1                -- ���� ��ȣ
  INCREMENT BY 1            -- ������
  MAXVALUE 9999999999  -- �ִ밪: 9999999999 --> NUMBER(10) ����
  CACHE 2                        -- 2���� �޸𸮿����� ���
  NOCYCLE;                      -- �ٽ� 1���� �����Ǵ� ���� ����

INSERT INTO admin(adminno, id, passwd, mname, mdate, grade)
VALUES(admin_seq.nextval, 'admin1', '1234', '������1', sysdate, 1);

INSERT INTO admin(adminno, id, passwd, mname, mdate, grade)
VALUES(admin_seq.nextval, 'admin2', '1234', '������2', sysdate, 1);

INSERT INTO admin(adminno, id, passwd, mname, mdate, grade)
VALUES(admin_seq.nextval, 'admin3', '1234', '������3', sysdate, 1);

commit;

SELECT adminno, id, passwd, mname, mdate, grade FROM admin ORDER BY adminno ASC;
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            ������1              2022-10-06 11:47:56          1
         2 admin2               1234            ������2              2022-10-06 11:47:56          1
         3 admin3               1234            ������3              2022-10-06 11:47:56          1
         
SELECT adminno, id, passwd, mname, mdate, grade 
FROM admin
WHERE adminno=1;
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            ������1              2022-10-06 11:47:56          1

SELECT adminno, id, passwd, mname, mdate, grade 
FROM admin
WHERE id='admin1';
   ADMINNO ID                   PASSWD          MNAME                MDATE                    GRADE
---------- -------------------- --------------- -------------------- ------------------- ----------
         1 admin1               1234            ������1              2022-10-06 11:47:56          1

UPDATE admin
SET passwd='1234', mname='������1', mdate=sysdate, grade=1
WHERE ADMINNO=1;

COMMIT;
         
DELETE FROM admin WHERE adminno=1;
-- ORA-02292: integrity constraint (KD.SYS_C007226) violated - child record found
-- �ڽ� ���̺��� adminno: 1�� �̿��ϰ��ֱ� ������ ���� ����. 

-- �α���
SELECT COUNT(*) as cnt
FROM admin
WHERE id='admin1' AND passwd='1234';
  
  
  