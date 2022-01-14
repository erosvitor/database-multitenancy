
CREATE DATABASE multischemas;

\connect multischemas;

-- This table will be created in 'public' schema
CREATE TABLE table01 (
  field VARCHAR(40)
);

INSERT INTO table01 (field) VALUES ('aaa'), ('bbb'), ('ccc');

-- Setting a new schema
CREATE SCHEMA schema_test;
SET search_path to schema_test;

-- This table will be created in 'schema_test' schema because it is current schema
CREATE TABLE table01 (
  field VARCHAR(40)
);

-- This will return 0 rows
SELECT * from table01;

-- This will return 3 rows
SELECT * from public.table01;
