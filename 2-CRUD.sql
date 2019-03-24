-- 2-CRUD (Create, Read, Update, Delete)


-- 2-1-Create (insert data)
INSERT INTO cats(name, age)
VALUES('Taco', 14);

-- 2-2-Read (read existing data)
-- show all columns and rows
SELECT * FROM table_name;
-- show specific columns (all rows)
SELECT column_name1, column_name2 -- the order matters
FROM table_name; 
-- e.g.
SELECT name, age FROM cats;
-- show specific rows (all columns)
SELECT *
FROM table_name
WHERE column_name1 = 'xxx' OR column_name2 = 1; -- case insensitive, column_name1 = 'xxx', 'xXx', 'XXX' will still return the same result
-- e.g.
SELECT * FROM cats WHERE age = 4 AND name = 'Egg';
-- give aliases
SELECT cat_id AS id, name FROM cats;
SELECT name AS 'cat name', breed AS 'kitty breed' FROM cats;

-- 2-3-Update (alter existing data) -- good rule of thumb: try SELECTing before you UPDATE
UPDATE table_name
SET column_name1 = 'aaa' -- change
WHERE column_name2 = 1; -- condition
-- e.g. 
UPDATE cats SET breed = 'Shorthair' WHERE breed = 'Tabby';
UPDATE cats SET age = 14 WHERE name = 'Misty';

-- 2-4-Delete -- always run SELECT first to double check
DELETE FROM cats WHERE name = 'Egg';
DELETE FROM cats; -- delete all rows but the table remains

