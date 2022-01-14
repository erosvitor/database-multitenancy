
CREATE DATABASE rls;

\connect rls;

CREATE TABLE books (
  id SERIAL,
  title VARCHAR(80) NOT NULL,
  author VARCHAR(30) NOT NULL,
  tenant VARCHAR(30) NOT NULL
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

ALTER TABLE books ENABLE ROW LEVEL SECURITY;

CREATE POLICY pol_books_tenant ON books USING (tenant = CURRENT_USER);

CREATE FUNCTION fnc_books_tenant() RETURNS trigger
AS $$
BEGIN
  NEW.tenant = CURRENT_USER;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tgr_books_tenant BEFORE INSERT ON books
FOR EACH ROW EXECUTE PROCEDURE fnc_books_tenant();

CREATE ROLE felipe LOGIN;
GRANT ALL ON books TO felipe;
GRANT USAGE, SELECT ON SEQUENCE books_id_seq TO felipe;

CREATE ROLE talita LOGIN;
GRANT ALL ON books TO talita;
GRANT USAGE, SELECT ON SEQUENCE books_id_seq TO talita;

SELECT * from books;

-- id |                      title                      |       author        | tenant 
-- ----+-------------------------------------------------+---------------------+--------
--  1 | QuickBooks 2008: The Official Guide             | Kathy Ivens         | felipe
--  2 | MySQL Cookbook                                  | Paul DuBois         | talita
--  3 | Excel 2007 For Dummies                          | Greg Harvey         | felipe
--  4 | The Digital Photography Book                    | Scott Kelby         | talita
--  5 | Oracle PL/SQL: Expert Techniques for Developers | Lakshman Bulusu     | felipe
--  6 | How to Cheat at Security SQL Server 2005        | Syngress Publishing | talita
--  7 | Beginning PHP and MySQL 5                       | W. Jason Gilmore    | felipe
--  8 | Beach Road                                      | James Patterson     | talita
-- (8 rows)


SET ROLE felipe;
SELECT * from books;

-- id |                      title                      |      author      | tenant 
-- ----+-------------------------------------------------+------------------+--------
--  1 | QuickBooks 2008: The Official Guide             | Kathy Ivens      | felipe
--  3 | Excel 2007 For Dummies                          | Greg Harvey      | felipe
--  5 | Oracle PL/SQL: Expert Techniques for Developers | Lakshman Bulusu  | felipe
--  7 | Beginning PHP and MySQL 5                       | W. Jason Gilmore | felipe
-- (4 rows)


SET ROLE talita;
SELECT * from books;

-- id |                  title                   |       author        | tenant 
-- ----+------------------------------------------+---------------------+--------
--  2 | MySQL Cookbook                           | Paul DuBois         | talita
--  4 | The Digital Photography Book             | Scott Kelby         | talita
--  6 | How to Cheat at Security SQL Server 2005 | Syngress Publishing | talita
--  8 | Beach Road                               | James Patterson     | talita
-- (4 rows)


SET ROLE postgres;
SELECT * from books;

-- id |                      title                      |       author        | tenant 
-- ----+-------------------------------------------------+---------------------+--------
--  1 | QuickBooks 2008: The Official Guide             | Kathy Ivens         | felipe
--  2 | MySQL Cookbook                                  | Paul DuBois         | talita
--  3 | Excel 2007 For Dummies                          | Greg Harvey         | felipe
--  4 | The Digital Photography Book                    | Scott Kelby         | talita
--  5 | Oracle PL/SQL: Expert Techniques for Developers | Lakshman Bulusu     | felipe
--  6 | How to Cheat at Security SQL Server 2005        | Syngress Publishing | talita
--  7 | Beginning PHP and MySQL 5                       | W. Jason Gilmore    | felipe
--  8 | Beach Road                                      | James Patterson     | talita
-- (8 rows)
