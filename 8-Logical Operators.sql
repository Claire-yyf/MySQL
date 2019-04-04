-- 8-Logical Operators


-- Not Equal

SELECT title FROM books WHERE released_year = 2017;
SELECT title FROM books WHERE released_year != 2017; -- select books that were not released in 2017
SELECT title, author_lname FROM books WHERE author_lname = 'Harris';
SELECT title, author_lname FROM books WHERE author_lname != 'Harris';


-- Not Like

SELECT title FROM books WHERE title LIKE 'W'; -- title is 'w'
SELECT title FROM books WHERE title LIKE 'W%'; -- title starts with 'w'
SELECT title FROM books WHERE title LIKE '%W%'; -- title contains 'w'
SELECT title FROM books WHERE title LIKE 'W%'; -- title ends with 'w'
SELECT title FROM books WHERE title NOT LIKE 'W%'; -- select books with titles that don't start with 'W'


-- Greater Than

SELECT title, released_year FROM books 
WHERE released_year > 2000 ORDER BY released_year; -- select books released after the year 2000

SELECT title, stock_quantity FROM books 
WHERE stock_quantity >= 100; -- select books with stock quantity more than 100
 
SELECT 99 > 1; -- 1; TRUE
SELECT 99 > 567; -- 0; FALSE
 
SELECT 'a' > 'b'; -- 0; FALSE
SELECT 'A' > 'a'; -- 0; FALSE
SELECT 'A' >= 'a'; -- 1; TRUE; so mysql is case insensitive as 'A' = 'a' is TRUE

 
-- Less Than

SELECT title, released_year FROM books
WHERE released_year < 2000 ORDER BY released_year; -- select books released before the year 2000
 
SELECT title, released_year FROM books
WHERE released_year <= 2000; -- select books released before the year 2000 including the year 2000
 
SELECT 3 < -10; -- 0; FALSE
SELECT -10 < -9; -- 1; TRUE
SELECT 42 <= 42; -- 1; TRUE
 
SELECT 'h' < 'p'; -- 1; TRUE
SELECT 'Q' <= 'q'; -- 1; TRUE; so mysql is case insensitive as 'Q' = 'q' is TRUE


-- Logical AND (&&) - all conditions need to be true

SELECT title, author_lname, released_year FROM books
WHERE author_lname = 'Eggers' AND released_year > 2010; -- 'AND' or '&&'
 
SELECT 1 < 5 && 7 = 9; -- 0; FALSE
SELECT -10 > -20 && 0 <= 0; -- 1; TRUE
SELECT -40 <= 0 AND 10 > 40; -- 0; FALSE 
SELECT 54 <= 54 && 'a' = 'A'; -- 1; TRUE 

SELECT * FROM books
WHERE author_lname = 'Eggers' AND released_year > 2010 AND title LIKE '%novel%';


-- Logical OR (||) - any one of the conditions needs to be true

SELECT title, author_lname, released_year FROM books
WHERE author_lname = 'Eggers' || released_year > 2010; -- 'OR' or '||'

SELECT 40 <= 100 || -2 > 0; -- 1; TRUE
SELECT 10 > 5 || 5 = 5; -- 1; TRUE
SELECT 'a' = 5 || 3000 > 2000; -- 1; TRUE
 
SELECT title, author_lname, released_year, stock_quantity FROM books 
WHERE author_lname = 'Eggers' || released_year > 2010 OR stock_quantity > 100;


-- Between

SELECT title, released_year FROM books WHERE released_year >= 2004 && released_year <= 2015;
-- is the same as 
SELECT title, released_year FROM books 
WHERE released_year BETWEEN 2004 AND 2015; -- 2004 and 2015 inclusive
 
SELECT title, released_year FROM books 
WHERE released_year NOT BETWEEN 2004 AND 2015;
 
SELECT CAST('2017-05-02' AS DATETIME); -- change string into datetime
 
SELECT name, birthdt FROM people 
WHERE birthdt BETWEEN '1980-01-01' AND '2000-01-01';
-- use CAST
SELECT name, birthdt FROM people
WHERE birthdt BETWEEN CAST('1980-01-01' AS DATETIME) AND CAST('2000-01-01' AS DATETIME);


-- In vs. Not In
 
SELECT title, author_lname FROM books
WHERE author_lname='Carver' OR
      author_lname='Lahiri' OR
      author_lname='Smith';
-- is the same as 
SELECT title, author_lname FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
 
SELECT title, released_year FROM books
WHERE released_year != 2000 AND
      released_year != 2002 AND
      released_year != 2004 AND
      released_year != 2006 AND
      released_year != 2008 AND
      released_year != 2010 AND
      released_year != 2012 AND
      released_year != 2014 AND
      released_year != 2016;
-- is the same as 
SELECT title, released_year FROM books
WHERE released_year NOT IN (2000,2002,2004,2006,2008,2010,2012,2014,2016);
 
SELECT title, released_year FROM books 
WHERE released_year >= 2000 AND released_year NOT IN (2000,2002,2004,2006,2008,2010,2012,2014,2016);
 
SELECT title, released_year FROM books
WHERE released_year >= 2000 AND released_year % 2 != 0 ORDER BY released_year; -- odd years


-- Case Statements

SELECT title, released_year,
    CASE 
        WHEN released_year >= 2000 THEN 'Modern Lit'
        ELSE '20th Century Lit'
    END AS GENRE
FROM books;
 
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;
-- is the same as
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books; 
 
SELECT title, 
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        WHEN stock_quantity BETWEEN 101 AND 150 THEN '***'
        ELSE '****'
    END AS STOCK
FROM books;
 

-- 197. Logical Operators Exercises

SELECT 10 != 10; -- 0
SELECT 15 > 14 && 99 - 5 <= 94; -- 1
SELECT 1 IN (5,3) || 9 BETWEEN 8 AND 10; -- 1

SELECT * FROM books WHERE released_year < 1980;

SELECT * FROM books WHERE author_lname IN ('Eggers', 'Chabon');
-- is the same as 
SELECT * FROM books WHERE author_lname='Eggers' OR author_lname='Chabon';

SELECT * FROM books WHERE author_lname = 'Lahiri' && released_year > 2000; 

SELECT * FROM books WHERE pages BETWEEN 100 AND 200; 
-- is the same as 
SELECT * FROM books WHERE pages >= 100 && pages <=200;

SELECT * FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';
-- is the same as 
SELECT * FROM books
WHERE 
    SUBSTR(author_lname,1,1) = 'C' OR 
    SUBSTR(author_lname,1,1) = 'S';
-- is the same as 
SELECT * FROM books WHERE SUBSTR(author_lname,1,1) IN ('C', 'S');

SELECT title, author_lname,
    CASE 
        WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title IN ('Just Kids', 'A Heartbreaking Work of Staggering Genius') THEN 'Memoir'
        ELSE 'Novel'
    END AS TYPE
FROM books;

SELECT title, author_lname,
    CASE 
        WHEN COUNT(*) = 1 THEN '1 book'
        ELSE CONCAT(COUNT(*), ' books')
    END AS COUNT
FROM books
GROUP BY author_lname, author_fname;

