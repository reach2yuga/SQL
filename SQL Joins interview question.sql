tbl1
| ID   |
| ---- |
| 1    |
| 1    |
| 1    |
| 2    |
| 2    |
| NULL |

tbl2
| ID   |
| ---- |
| 1    |
| 1    |
| 1    |
| 2    |
| NULL |

-- Create tbl1
CREATE TABLE tbl1 (
    ID INT
);

-- Insert records into tbl1
INSERT INTO tbl1 (ID) VALUES
(1),
(1),
(1),
(2),
(2),
(NULL);

-- Create tbl2
CREATE TABLE tbl2 (
    ID INT
);

-- Insert records into tbl2
INSERT INTO tbl2 (ID) VALUES
(1),
(1),
(1),
(2),
(NULL);


SELECT tbl1.ID AS tbl1_ID, tbl2.ID AS tbl2_ID
FROM tbl1
INNER JOIN tbl2 ON tbl1.ID = tbl2.ID;


SELECT tbl1.ID AS tbl1_ID, tbl2.ID AS tbl2_ID
FROM tbl1
LEFT JOIN tbl2 ON tbl1.ID = tbl2.ID;

SELECT tbl1.ID AS tbl1_ID, tbl2.ID AS tbl2_ID
FROM tbl1
RIGHT JOIN tbl2 ON tbl1.ID = tbl2.ID;


SELECT tbl1.ID AS tbl1_ID, tbl2.ID AS tbl2_ID
FROM tbl1
FULL OUTER JOIN tbl2 ON tbl1.ID = tbl2.ID;


SELECT ID FROM tbl1
UNION
SELECT ID FROM tbl2;


SELECT ID FROM tbl1
UNION ALL
SELECT ID FROM tbl2;

| Operation  | Count |
| ---------- | ----- |
| INNER JOIN | 11    |
| LEFT JOIN  | 12    |
| RIGHT JOIN | 12    |
| FULL JOIN  | 14    |
| UNION      | 3     |
| UNION ALL  | 11    |




