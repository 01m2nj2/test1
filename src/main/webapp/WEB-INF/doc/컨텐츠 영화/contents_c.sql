DROP TABLE attachfile;
DROP TABLE contents CASCADE CONSTRAINTS;
DROP TABLE contents;

CREATE TABLE contents(
        contentsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        adminno                              NUMBER(10)     NOT NULL , -- FK
        cateno                                NUMBER(10)         NOT NULL , -- FK
        title                                 VARCHAR2(50)         NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        passwd                                VARCHAR2(15)         NOT NULL,
        word                                  VARCHAR2(100)         NULL ,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,  -- ���� ���ϸ� image
        file1saved                            VARCHAR(100)          NULL,  -- ����� ���ϸ�, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- ���� ������
        price                                  VARCHAR(100)          NULL,  
        dc                                    NUMBER(10)      DEFAULT 0 NULL,  
        saleprice                            NUMBER(10)      DEFAULT 0 NULL,  
        point                                 VARCHAR2(50)    NULL,  
        salecnt                               NUMBER(10)      DEFAULT 0 NULL,
        map                                   VARCHAR2(1000)            NULL,
        youtube                               VARCHAR2(1000)            NULL,
  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (cateno) REFERENCES cate (cateno)
);

COMMENT ON TABLE contents is '������ - ��ȭ ��ǰ';
COMMENT ON COLUMN contents.contentsno is '������ ��ȣ';
COMMENT ON COLUMN contents.adminno is '������ ��ȣ';
COMMENT ON COLUMN contents.cateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN contents.title is '����';
COMMENT ON COLUMN contents.content is '����';
COMMENT ON COLUMN contents.recom is '��õ��';
COMMENT ON COLUMN contents.cnt is '��ȸ��';
COMMENT ON COLUMN contents.replycnt is '��ۼ�';
COMMENT ON COLUMN contents.passwd is '�н�����';
COMMENT ON COLUMN contents.word is '�˻���';
COMMENT ON COLUMN contents.rdate is '�����';
COMMENT ON COLUMN contents.file1 is '���� �̹���';
COMMENT ON COLUMN contents.file1saved is '���� ����� ���� �̹���';
COMMENT ON COLUMN contents.thumb1 is '���� �̹��� Preview';
COMMENT ON COLUMN contents.size1 is '���� �̹��� ũ��';
COMMENT ON COLUMN contents.price is '����';
COMMENT ON COLUMN contents.dc is '���η�';
COMMENT ON COLUMN contents.saleprice is '�ǸŰ�';
COMMENT ON COLUMN contents.point is '����Ʈ';
COMMENT ON COLUMN contents.salecnt is '����';
COMMENT ON COLUMN contents.map is '����';
COMMENT ON COLUMN contents.youtube is 'Youtube ����';

commit;

DROP SEQUENCE contents_seq;

CREATE SEQUENCE contents_seq
  START WITH 1                -- ���� ��ȣ
  INCREMENT BY 1            -- ������
  MAXVALUE 9999999999  -- �ִ밪: 9999999999 --> NUMBER(10) ����
  CACHE 2                        -- 2���� �޸𸮿����� ���
  NOCYCLE;                      -- �ٽ� 1���� �����Ǵ� ���� ����

-- CATE, ADMIN ���̺� ���ڵ尡 ���� ���, adminno: 1, cateno: 1���� �̿��� ���� ����. ���(X)
-- ORA-02291: integrity constraint (AI8.SYS_C007066) violated - parent key not found
--INSERT INTO contents(contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
--                              file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt)
--VALUES(contents_seq.nextval, 1, 1, '���ͽ��ڶ�', '���켭���� �ֿ�', 0, 0, 0, '123', '����', sysdate,
--            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 2000, 10, 1800, 100, 500);


-- FK �÷��� ���� ������ ��ϵǾ����� Ȯ��
--CATE ���̺�
--    CATENO NAME                                  CNT RDATE               UDATE                    SEQNO V
------------ ------------------------------ ---------- ------------------- ------------------- ---------- -
--         1 ��                                    0 2022-09-06 04:42:46                              1 Y
--         2 SF                                      0 2022-09-06 04:42:46                              2 Y
--         3 ���                                  0 2022-09-06 04:42:46                              3 Y
--         4 ��õ ������                             0 2022-09-06 04:42:46                              4 Y
--
--ADMIN ���̺�
--   ADMINNO ID                  
------------ --------------------
--         1 admin1              
--         2 admin2              
--         3 admin3              
--
--CONTENTS ���̺�
--CREATE TABLE contents(
--        contentsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
--        adminno                              NUMBER(10)     NOT NULL , -- FK
--        cateno                                NUMBER(10)         NOT NULL , -- FK
--        .....
--        FOREIGN KEY (adminno) REFERENCES admin (adminno),
--        FOREIGN KEY (cateno) REFERENCES cate (cateno)

-- ��� ȭ�� ���� 1: Ŀ�´�Ƽ(��������, �Խ���, �ڷ��, ������,  Q/A...)�� ���
INSERT INTO contents(contentsno, adminno, cateno, title, content, passwd, word,
                                 file1, file1saved, thumb1, size1, rdate)
VALUES(contents_seq.nextval, 1, 1, 'AI', '�ֵ�� �ֿ�', '123', '�κ�,�ΰ�����', 
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, sysdate);

-- ���� 1 ��ü ���
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1
FROM contents
ORDER BY contentsno ASC;

-- ��� ȭ�� ���� 2 ���� �Է� �÷�: ����, ���η�, �ǸŰ�, ����Ʈ, ������
-- ���θ��� ��ǰ ���� ���
INSERT INTO contents(contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
                              file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt)
VALUES(contents_seq.nextval, 1, 1, '����', '�䵥�̸� �ֿ� ȭ�� Ż��', 0, 0, 0, '123', '����', sysdate,
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 2000, 10, 1800, 100, 500);
            
INSERT INTO contents(contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
                              file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt)
VALUES(contents_seq.nextval, 1, 1, 'AI', '�ֵ��', 0, 0, 0, '123', '�κ�,�ΰ�����', sysdate,
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 2000, 10, 1800, 100, 500);
COMMIT;

-- ���� 2 ��ü ���
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
FROM contents
ORDER BY contentsno ASC;

-- ��� ���ڵ� ����
DELETE FROM contents;
commit;

-- ����
DELETE FROM contents
WHERE contentsno = 25;
commit;

DELETE FROM contents
WHERE cateno=12 AND contentsno <= 41;

commit;


-- ----------------------------------------------------------------------------------------------------
-- �˻�, cateno�� �˻� ���
-- ----------------------------------------------------------------------------------------------------
-- ����
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
FROM contents
ORDER BY contentsno ASC;

-- ī�װ��� ���
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
FROM contents
WHERE cateno=2
ORDER BY contentsno ASC;

-- 1) �˻�
-- �� cateno�� �˻� ���
-- word �÷��� ���� ����: �˻� ��Ȯ���� ���̱� ���Ͽ� �߿� �ܾ ���
-- �ۿ� 'swiss'��� �ܾ �����ϸ� �ѱ۷� '������'�� �˻� �ȵ�.
-- �̷� ������ �����ϱ����� 'swiss,������,���ǽ�,���ǽ�,����' �˻�� �� word �÷��� �߰���.
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
FROM contents
WHERE cateno=2 AND word LIKE '%�δ����%'
ORDER BY contentsno DESC;

-- title, content, word column search
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
FROM contents
WHERE cateno=2 AND (title LIKE '%�δ����%' OR content LIKE '%�δ����%' OR word LIKE '%�δ����%')
ORDER BY contentsno DESC;

-- �� �˻� ���ڵ� ����
-- ��ü ���ڵ� ����, ���� �Լ�
SELECT COUNT(*)
FROM contents
WHERE cateno=2;


----------
SELECT COUNT(*) as cnt -- �Լ� ���ô� �÷� ������ �����ϴ� ���� ����
FROM contents
WHERE cateno=2;


-- cateno �� �˻��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=2 AND word LIKE '%�δ����%';

SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=2 AND (title LIKE '%�δ����%' OR content LIKE '%�δ����%' OR word LIKE '%�δ����%');

-- SUBSTR(�÷���, ���� index(1���� ����), ����), �κ� ���ڿ� ����
SELECT contentsno, SUBSTR(title, 1, 4)
FROM contents
WHERE cateno=2 AND (content LIKE '%�δ�%');

-- ��ҹ��ڸ� �����Ͽ� �˻�
SELECT contentsno, title, word
FROM contents
WHERE cateno=2 AND (word LIKE '%FOOD%');

SELECT contentsno, title, word
FROM contents
WHERE cateno=2 AND (word LIKE '%food%'); -- ��ҹ��� �������� �˻� �ȵ�.

SELECT contentsno, title, word
FROM contents
WHERE cateno=2 AND (LOWER(word) LIKE '%food%'); -- ��ҹ��ڸ� ��ġ ���Ѽ� �˻�

SELECT contentsno, title, word
FROM contents
WHERE cateno=2 AND (UPPER(word) LIKE '%' || UPPER('FOOD') || '%'); -- ��ҹ��ڸ� ��ġ ���Ѽ� �˻�

SELECT contentsno, title, word
FROM contents
WHERE cateno=2 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- ��ҹ��ڸ� ��ġ ���Ѽ� �˻�

SELECT contentsno || '. ' || title || ' �±�: ' || word as title -- �÷��� ����, ||
FROM contents
WHERE cateno=2 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- ��ҹ��ڸ� ��ġ ���Ѽ� �˻�


SELECT UPPER('�ѱ�') FROM dual; -- dual: ����Ŭ���� SQL ������ ���߱����� �ý��� ���̺�

-- ----------------------------------------------------------------------------------------------------
-- cate + contents INNER JOIN
-- ----------------------------------------------------------------------------------------------------
-- ����
SELECT c.name,
       t.contentsno, t.adminno, t.cateno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.price, t.dc, t.saleprice, t.point, t.salecnt, t.map, t.youtube
FROM cate c, contents t
WHERE c.cateno = t.cateno
ORDER BY t.contentsno DESC;


-- ----------------------------------------------------------------------------------------------------
-- �˻� + ����¡ + ���� �̹���, ���� -> rownum -> ����
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
FROM contents
WHERE cateno=1 AND (title LIKE '%��ǳ%' OR content LIKE '%��ǳ%' OR word LIKE '%��ǳ%')
ORDER BY contentsno DESC;

-- step 2
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube, rownum as r
FROM (
          SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                     file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
          FROM contents
          WHERE cateno=1 AND (title LIKE '%��ǳ%' OR content LIKE '%��ǳ%' OR word LIKE '%��ǳ%')
          ORDER BY contentsno DESC
);

-- step 3, 1 page
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube, r
FROM (
           SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
                     FROM contents
                     WHERE cateno=1 AND (title LIKE '%��ǳ%' OR content LIKE '%��ǳ%' OR word LIKE '%��ǳ%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube, r
FROM (
           SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
                     FROM contents
                     WHERE cateno=1 AND (title LIKE '%��ǳ%' OR content LIKE '%��ǳ%' OR word LIKE '%��ǳ%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- ----------------------------------------------------------------------------
-- ��ȸ
-- ----------------------------------------------------------------------------
SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, price, dc, saleprice, point, salecnt, map, youtube
FROM contents
WHERE contentsno = 1;

-- ----------------------------------------------------------------------------
-- ���� ����, MAP, ���� ���ڵ尡 ��ϵǾ� �־����.
-- map ? ? ? ? ? ? ? ? ? ? ? ? ? ?? ??? ?VARCHAR2(1000)?? ??? ? NULL ,
-- ----------------------------------------------------------------------------
-- MAP ���/����
UPDATE contents SET map='ī��� ���� ��ũ��Ʈ' WHERE contentsno=1;

-- MAP ����
UPDATE contents SET map='' WHERE contentsno=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, ���� ���ڵ尡 ��ϵǾ� �־����.
-- youtube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- youtube ���/����
UPDATE contents SET youtube='Youtube ��ũ��Ʈ' WHERE contentsno=1;

-- youtube ����
UPDATE contents SET youtube='' WHERE contentsno=1;

commit;

-- ----------------------------------------------------------------------------
-- �� ����
-- ----------------------------------------------------------------------------
-- �ؽ�Ʈ ����: ���� �÷�: ��õ��, ��ȸ��, ��� ��
UPDATE contents
SET price='���ѹα�'
WHERE contentsno = 4;

commit;

-- ERROR, SQL ����: ORA-00904: "��ȹ���� '����' ���": invalid identifier
UPDATE contents
SET title='������ Ÿ��', content="��ȹ���� '����' ���",  word='��,����,����', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 22;

-- ERROR, SQL ����: ORA-00933: SQL command not properly ended
UPDATE contents
SET title='������ Ÿ��', content='��ȹ���� \'����\' ���',  word='��,����,����', 
      price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 22;

-- SUCCESS
UPDATE contents
SET title='���� ������', content='�¹��� ''����'' ����',  word='��,����,����', 
    price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 22;

commit;

-- SUCCESS
UPDATE contents
SET title='�̽÷��� ����', content='����̺�� "�̽÷� ����" �̿�',  word='��,����,����', 
    price=10000, dc=5, saleprice=9500, point=500, salecnt=100
WHERE contentsno = 22;

commit;

-- ----------------------------------------------------------------------------
-- ���� ����
-- ----------------------------------------------------------------------------
-- ���� ����
UPDATE contents
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE contentsno = 1;

commit;


-- ����
DELETE FROM contents
WHERE contentsno = 15;

commit;

SELECT * FROM contents;

-- ��õ
UPDATE contents
SET recom = recom + 1
WHERE contentsno = 1;

-- Ư�� ī�װ��� ���� ���ڵ� ���� ����
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;

-- Ư�� �����ڿ� ���� ���ڵ� ���� ����
SELECT COUNT(*) as cnt 
FROM contents 
WHERE adminno=1;

-- Ư�� �׷쿡 ���� ���ڵ� ��� ����
DELETE FROM contents
WHERE cateno=1;

-- Ư�� �����ڿ� ���� ���ڵ� ��� ����
DELETE FROM contents
WHERE adminno=1;

-- �ټ��� ī�װ��� ���� ���ڵ� ���� ����: IN
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno IN(1,2,3);

-- �ټ��� ī�װ��� ���� ���ڵ� ��� ����: IN
SELECT contentsno, adminno, cateno, title
FROM contents
WHERE cateno IN(1,2,3);

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           ���ͽ��ڶ�                                                                                                                                                                                                                                                                                                  
         4             1                   2           ���                                                                                                                                                                                                                                                                                                      
         5             1                   3           ������                                                                                                                                                                                                                                                                                                      
         6             1                   1           ����       
         
SELECT contentsno, adminno, cateno, title
FROM contents
WHERE cateno IN('1','2','3');

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           ���ͽ��ڶ�                                                                                                                                                                                                                                                                                                  
         4             1                   2           ���                                                                                                                                                                                                                                                                                                      
         5             1                   3           ������                                                                                                                                                                                                                                                                                                      
         6             1                   1           ����       



