
CREATE DATABASE rls;

USE rls;

CREATE TABLE books (
  id INT AUTO_INCREMENT NOT NULL,
  title VARCHAR(80) NOT NULL,
  author VARCHAR(30) NOT NULL,
  tenant VARCHAR(30) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO books (title, author, tenant)
VALUES
  ('QuickBooks 2008: The Official Guide', 'Kathy Ivens', 'felipe'),
  ('MySQL Cookbook', 'Paul DuBois', 'talita'),
  ('Excel 2007 For Dummies', 'Greg Harvey', 'felipe'),
  ('The Digital Photography Book', 'Scott Kelby', 'talita'),
  ('Oracle PL/SQL: Expert Techniques for Developers', 'Lakshman Bulusu', 'felipe'),
  ('How to Cheat at Security SQL Server 2005', 'Syngress Publishing', 'talita'),
  ('Beginning PHP and MySQL 5', 'W. Jason Gilmore', 'felipe'),
  ('Beach Road', 'James Patterson', 'talita')
;

CREATE VIEW vw_books(
  title,
  author
)
AS
SELECT 
  books.title AS title,
  books.author AS author
FROM
  books 
WHERE
  (books.tenant = SUBSTRING_INDEX(USER(), '@', 1));

CREATE USER 'felipe'@'localhost' IDENTIFIED BY 'felipe';
GRANT ALL PRIVILEGES ON rls.vw_books TO 'felipe'@'localhost';
GRANT INSERT, UPDATE, DELETE, TRIGGER ON rls.books TO 'felipe'@'localhost';

DELIMITER |
CREATE TRIGGER tr_books_before_insert BEFORE INSERT ON books FOR EACH ROW
BEGIN
  SET NEW.tenant = SUBSTRING_INDEX(USER(), '@', 1);
END|
CREATE TRIGGER tr_books_before_update BEFORE UPDATE ON books FOR EACH ROW
BEGIN
  SET NEW.tenant = SUBSTRING_INDEX(user(), '@', 1);
END|
DELIMITER ;

-- LOGIN as 'felipe'

-- mysql> SELECT * FROM books;
-- ERROR 1142 (42000): SELECT command denied to user 'felipe'@'localhost' for table 'books'

-- mysql> SELECT * FROM vw_books;
-- +-------------------------------------------------+------------------+
-- | title                                           | author           |
-- +-------------------------------------------------+------------------+
-- | QuickBooks 2008: The Official Guide             | Kathy Ivens      |
-- | Excel 2007 For Dummies                          | Greg Harvey      |
-- | Oracle PL/SQL: Expert Techniques for Developers | Lakshman Bulusu  |
-- | Beginning PHP and MySQL 5                       | W. Jason Gilmore |
-- +-------------------------------------------------+------------------+
-- 4 rows in set (0,00 sec)

-- mysql> INSERT INTO vw_books (title, author) VALUES ('Wisdom of Our Fathers', 'Tim Russert');

-- mysql> SELECT * FROM vw_books;
-- +-------------------------------------------------+------------------+
-- | title                                           | author           |
-- +-------------------------------------------------+------------------+
-- | QuickBooks 2008: The Official Guide             | Kathy Ivens      |
-- | Excel 2007 For Dummies                          | Greg Harvey      |
-- | Oracle PL/SQL: Expert Techniques for Developers | Lakshman Bulusu  |
-- | Beginning PHP and MySQL 5                       | W. Jason Gilmore |
-- | Wisdom of Our Fathers                           | Tim Russert      |
-- +-------------------------------------------------+------------------+
-- 5 rows in set (0,01 sec)

-- LOGIN as 'root'

-- mysql> SELECT * FROM books;


