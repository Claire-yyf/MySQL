-- 0-Exercises


/*
63. Table Constrain Exercises
Define an Employees table, with the following fields:
id - number(automatically increments), mandatory, primary key
last_name - text, mandatory
first_name - text, mandatory
middle_name - text, not mandatory
age - number mandatory
current_status - text, mandatory, defaults to 'employed'
*/

CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    age INTEGER NOT NULL,
    current_status VARCHAR(100) NOT NULL DEFAULT 'employed',
    PRIMARY KEY (id) -- assign primary key here
);

CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, -- assign primary key here
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    age INTEGER NOT NULL,
    current_status VARCHAR(100) NOT NULL DEFAULT 'employed'
);


/*
75. SELECT Exercises
*/

SELECT cat_id 
FROM cats;

SELECT name, breed 
FROM cats;

SELECT name, age
FROM cats
WHERE breed = 'Tabby';

SELECT cat_id, age
FROM cats
WHERE cat_id = age;

SELECT * 
FROM cats 
WHERE cat_id = age; 


/*
82. UPDATE Exercises
*/

UPDATE cats SET name = 'Jack'
WHERE name = 'Jackson';

UPDATE cats SET breed = 'British Shorthair'
WHERE name = 'Ringo';

UPDATE cats SET age = 12
WHERE breed = 'Maine Coon';


/*
87. DELETE Exercises
*/

DELETE FROM cats WHERE age = 4;

DELETE FROM cats WHERE age = cat_id;

DELETE FROM cats; 


/*
90. CRUD Exercises
*/

-- create
CREATE DATABASE shirts_db;

SHOW DATABASES; 

USE shirts_db; 

SELECT database();

CREATE TABLE shirts(
    shirt_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	article VARCHAR(50), 
    color VARCHAR(50),
    shirt_size VARCHAR(50), 
    last_worn INT
); 

DESC shirts;

INSERT INTO shirts(article, color, shirt_size, last_worn)
VALUES ('t-shirt', 'white', 'S', 10),
        ('t-shirt', 'green', 'S', 200),
        ('polo shirt', 'black', 'M', 10),
        ('tank top', 'blue', 'S', 50),
        ('t-shirt', 'pink', 'S', 0),
        ('polo shirt', 'red', 'M', 5),
        ('tank top', 'white', 'S', 200),
        ('tank top', 'blue', 'M', 15);

INSERT INTO shirts(color, article, shirt_size, last_worn) 
VALUES('purple', 'polo shirt', 'M', 50);

-- read
SELECT * FROM shirts;

SELECT article, color FROM shirts;

SELECT article, color, shirt_size, last_worn 
FROM shirts
WHERE shirt_size = 'M';

-- update
SELECT * FROM shirts WHERE article = 'polo shirt';
UPDATE shirts SET shirt_size = 'L' WHERE article = 'polo shirt';
SELECT * FROM shirts WHERE article = 'polo shirt';

SELECT * FROM shirts WHERE last_worn = 15;
UPDATE shirts SET last_worn = 0 WHERE last_worn = 15;
SELECT * FROM shirts WHERE last_worn = 15;
SELECT * FROM shirts WHERE last_worn = 0;

SELECT * FROM shirts WHERE color = 'white';
UPDATE shirts SET shirt_size = 'XS', color = 'off white' WHERE color = 'white';
SELECT * FROM shirts WHERE color = 'white';
SELECT * FROM shirts WHERE color = 'off white';

-- delete
SELECT * FROM shirts WHERE last_worn = 200;
DELETE FROM shirts WHERE last_worn = 200;
SELECT * FROM shirts WHERE last_worn = 200; -- empty set

SELECT * FROM shirts WHERE article = 'tank top';
DELETE FROM shirts WHERE article = 'tank top';
SELECT * FROM shirts WHERE article = 'tank top'; -- empty set

SELECT * FROM shirts;
DELETE FROM shirts;
SELECT * FROM shirts; -- empty set

DROP TABLE shirts; 
SHOW TABLES; -- empty set
DESC shirts; -- error because shirts table does not exist  
 

/*
118. String Function Exercises
*/

SELECT UPPER(REVERSE('Why does my cat look at me with such hatred?')); -- ?DERTAH HCUS HTIW EM TA KOOL TAC YM SEOD YHW 
SELECT REPLACE(CONCAT('I', ' ', 'like', ' ', 'cats'), ' ', '-'); -- I-like-cats

SELECT REPLACE(title, ' ', '->') AS title 
FROM books; 

SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards 
FROM books; 

SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps' 
FROM books;

SELECT CONCAT(title, ' was released in ', released_year) AS blurb 
FROM books;

SELECT title, CHAR_LENGTH(title) AS 'character count' 
FROM books;

SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS 'short title',
        CONCAT(author_lname, ',', author_fname) AS author,
        CONCAT(stock_quantity, ' in stock') AS quantity
FROM books;
