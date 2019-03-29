-- 5-Refining Selections


-- 5-1-DISTINCT (Get unique values)

SELECT author_lname FROM books; -- get all authors' last names
SELECT DISTINCT author_lname FROM books; -- get all unique authors' last names (excludes duplicates)

SELECT author_fname, author_lname FROM books; -- get all authors' full names
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) FROM books; -- get distinct authors' full names (each individual author)
SELECT DISTINCT author_fname, author_lname FROM books; -- get distinct authors' first names and last names (each individual author)


-- 5-2-ORDER BY (Sorting results)

SELECT author_lname FROM books;
SELECT author_lname FROM books ORDER BY author_lname; -- ascending order by default
SELECT author_lname FROM books ORDER BY author_lname ASC; -- ascending order
SELECT author_lname FROM books ORDER BY author_lname DESC; -- descending order
 
SELECT released_year FROM books;
SELECT released_year FROM books ORDER BY released_year; -- ascending order by default
SELECT released_year FROM books ORDER BY released_year ASC; -- ascending order
SELECT released_year FROM books ORDER BY released_year DESC; -- descending order
 
SELECT title, released_year, pages FROM books ORDER BY released_year;
SELECT title, pages FROM books ORDER BY released_year; -- don't need to select the column that is used to sort
 
SELECT title, author_fname, author_lname 
FROM books ORDER BY 1; -- 1 is the 1st column in the SELECT statement i.e. title; the order in the SELECT statement matters

SELECT title, author_fname, author_lname 
FROM books ORDER BY 2 DESC; -- ordered by author_fname in descending order
 
SELECT author_fname, author_lname FROM books 
ORDER BY author_lname, author_fname; -- sorted by author_lname, and then sorted by author_fname


-- 5-3-LIMIT (Specify the number of results shown)

SELECT title FROM books LIMIT 10; -- LIMIT the number of rows needed 

SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 5; -- get the title and released_year for the 5 most recent books
 
SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 0, 5; -- LIMIT the starting row, the number of rows needed; get 5 rows from the 1st row (0) onwards; row 1-5
 
SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 10, 1; -- get 1 row from the 11th row (10) onwards; row 11
 
SELECT title FROM books LIMIT 3; -- get the titles for the first 3 books
SELECT title FROM books LIMIT 3, 123219476457; -- get all rows from the 4th row to the end of the result set; use some large number for the second parameter


-- 5-4-LIKE (Search for similar values)

SELECT title, author_fname FROM books WHERE author_fname LIKE '%da%'; -- where author_fname contain 'da'; % wildcards, case insensitive
SELECT title, author_fname FROM books WHERE author_fname LIKE 'da%'; -- where author_fname start with 'da'; % wildcards, case insensitive
 
SELECT title FROM books WHERE title LIKE 'the'; -- where title is 'the'; empty set
SELECT title FROM books WHERE title LIKE '%the'; -- where title end with 'the'; empty set  
SELECT title FROM books WHERE title LIKE '%the%'; -- where title contain 'the'

SELECT title, stock_quantity FROM books;
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '____'; -- 4 underscores mean 4 characters/digits
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '__'; -- 2 underscores mean 2 characters/digits
 
(235)234-0987 LIKE '(___)___-____' -- match patterns
 
SELECT title FROM books;
SELECT title FROM books WHERE title LIKE '%\%%'; -- where title contain '%'; \ is a escape character
SELECT title FROM books WHERE title LIKE '%\_%'; -- where title contain '_'; \ is a escape character