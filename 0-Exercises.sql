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
    PRIMARY KEY (id) # assign primary key here
);

CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, # assign primary key here
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

