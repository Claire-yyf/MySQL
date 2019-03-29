-- 4-String Functions
-- sql formatter: sql-format.com


-- 4-1-CONCAT (Combine data for cleaner output)

CONCAT(column1, column2)
CONCAT(column1, 'text1', column2, 'text2')
-- e.g.
CONCAT(author_fname, author_lname) -- e.g. DaveEggers
CONCAT(author_fname, ' ', author_lname) -- e.g. Dave Eggers
 
SELECT CONCAT('Hello', 'World'); -- HelloWorld
SELECT CONCAT('Hello', '...', 'World'); -- Hello...World
 
SELECT CONCAT(author_fname, ' ', author_lname)
FROM books;
 
SELECT CONCAT(author_fname, ' ', author_lname) AS 'full name'
FROM books;
 
SELECT author_fname AS first, author_lname AS last, 
    CONCAT(author_fname, ' ', author_lname) AS full
FROM books;
 
SELECT author_fname AS first, author_lname AS last, 
    CONCAT(author_fname, ', ', author_lname) AS full
FROM books;
 
SELECT CONCAT(title, ' - ', author_fname, ' - ', author_lname) 
FROM books;
-- is the same as
SELECT CONCAT_WS(' - ', title, author_fname, author_lname) -- Concat With Separator
FROM books;


-- 4-2-SUBSTRING (Work with parts of strings)

SELECT SUBSTRING('Hello World', 1, 4); -- Hell 
SELECT SUBSTRING('Hello World', 7); -- World
SELECT SUBSTRING('Hello World', -3); -- rld
SELECT SUBSTRING('Hello World', -7); -- o World
 
SELECT title FROM books;
SELECT SUBSTRING(title, 1, 10) FROM books;
SELECT SUBSTRING(title, 1, 10) AS 'short title' FROM books;
-- is the same as
SELECT SUBSTR(title, 1, 10) AS 'short title' FROM books;
 
SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS 'short title'
FROM books;


-- 4-3-REPLACE (Replace parts of strings)

SELECT REPLACE('Hello World', 'Hell', '%$#@'); -- %$#@o World   
SELECT REPLACE('Hello World', 'l', '7'); -- He77o Wor7d
SELECT REPLACE('Hello World', 'o', '0'); -- Hell0 W0rld
SELECT REPLACE('HellO World', 'o', '*'); -- HellO W*rld; case sensitive
SELECT REPLACE('cheese bread coffee milk', ' ', ' and '); -- cheese and bread and coffee and milk   

SELECT REPLACE(title, 'e ', '3') FROM books;

SELECT SUBSTRING(REPLACE(title, 'e', '3'), 1, 10) AS 'weird string'
FROM books;


-- 4-4-REVERSE (Get the reversed version of a string)

SELECT REVERSE('Hello World'); -- dlroW olleH
SELECT REVERSE('meow meow'); -- woem woem
SELECT REVERSE(author_fname) FROM books;
SELECT CONCAT('woof', REVERSE('woof')); -- wooffoow 
SELECT CONCAT(author_fname, REVERSE(author_fname)) FROM books;


-- 4-5-CHAR_LENGTH (Count characters in string)

SELECT CHAR_LENGTH('Hello World'); -- 11
SELECT author_lname, CHAR_LENGTH(author_lname) AS 'length' FROM books;
SELECT CONCAT(author_lname, ' is ', CHAR_LENGTH(author_lname), ' characters long') FROM books;


-- 4-6-UPPER and LOWER (Change a string's case)

SELECT UPPER('Hello World'); -- HELLO WORLD
SELECT LOWER('Hello World'); -- hello world  
SELECT UPPER(title) FROM books;
SELECT CONCAT('MY FAVORITE BOOK IS ', UPPER(title)) FROM books;
SELECT CONCAT('MY FAVORITE BOOK IS ', LOWER(title)) FROM books;

