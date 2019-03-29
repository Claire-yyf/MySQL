-- 6-Aggregate Functions


-- 6-1-COUNT

SELECT COUNT(*) FROM books; -- how many books are in the table; 19
SELECT COUNT(author_fname) FROM books; -- how many authors first names are in the table; 19
SELECT COUNT(DISTINCT author_fname) FROM books; -- how many unique authors first names are in the table; 12
SELECT COUNT(DISTINCT author_lname) FROM books; -- how many unique authors last names are in the table; 11
SELECT COUNT(DISTINCT author_lname, author_fname) FROM books; -- how many unique authors are in the table; 12

SELECT title FROM books WHERE title LIKE '%the%'; 
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';


-- 6-2-GROUP BY (Summarizes or aggregates identical data into single rows)

SELECT title, author_fname, author_lname FROM books;
SELECT title, author_fname, author_lname FROM books GROUP BY author_lname; -- not useful 
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname; 
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname; -- COUNT how many books each author has written
 
SELECT released_year FROM books;
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
SELECT CONCAT('In ', released_year, ' ', COUNT(*), ' book(s) released') AS year FROM books GROUP BY released_year;


-- 6-3-MIN and MAX

SELECT MIN(released_year) FROM books;
SELECT MAX(released_year) FROM books;
SELECT MIN(pages) FROM books;
SELECT MAX(pages) FROM books;

SELECT MAX(pages), title FROM books; -- find the longest book, it doesn't work
-- use subqueries
SELECT title, pages FROM books 
WHERE pages = (SELECT MAX(pages) FROM books); -- find the longest book
SELECT title, pages FROM books 
WHERE pages = (SELECT MIN(pages) FROM books); -- find the shortest book
-- use ORDER BY
SELECT title, pages FROM books 
ORDER BY pages DESC LIMIT 1; -- find the longest book
SELECT title, pages FROM books  
ORDER BY pages ASC LIMIT 1; -- find the shortest book

-- MIN and MAX with GROUP BY
SELECT author_fname, author_lname, MIN(released_year) FROM books 
GROUP BY author_lname, author_fname; -- find the year each author published their first book
 
SELECT author_fname, author_lname, MAX(pages) FROM books
GROUP BY author_lname, author_fname; -- find the longest page count for each author
 
SELECT
    CONCAT(author_fname, ' ', author_lname) AS author,
    MAX(pages) AS 'longest book'
FROM books
GROUP BY author_lname, author_fname; -- find the longest page count for each author


-- 6-4-SUM

SELECT SUM(pages) FROM books; -- sum all pages in the entire database
SELECT SUM(released_year) FROM books;
 
-- SUM with GROUP BY
SELECT author_fname, author_lname, SUM(pages) FROM books
GROUP BY author_lname, author_fname; -- sum all pages each author has written
 
SELECT author_fname, author_lname, SUM(released_year) FROM books
GROUP BY author_lname, author_fname;


-- 6-5-AVG

SELECT AVG(released_year) FROM books; -- get the average released_year across all books
SELECT AVG(pages) FROM books; -- get the average number of pages across all books
 
-- AVG with GROUP BY
SELECT released_year, AVG(stock_quantity) FROM books 
GROUP BY released_year; -- get the average stock quantity for books released in the same year
 
SELECT author_fname, author_lname, AVG(pages) FROM books
GROUP BY author_lname, author_fname; -- average number of pages each author has written
