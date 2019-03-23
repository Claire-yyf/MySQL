-- 1-Creating databases, tables and inserting data


-- get help
help; 
 
-- show hostname
select @@hostname; 

-- start mysql
mysql-ctl start 

-- stop mysql
mysql-ctl stop 

-- start mysql command line interface
mysql-ctl cli 

-- stop mysql command line interface
exit;
quit;
\q;
ctrl-c 

-- list available databases
SHOW DATABASES; 
 
-- create a database
CREATE DATABASE database_name; 

-- drop a database
DROP DATABASE database_name; 

-- use a database
USE database_name; 

-- show current database in use
SELECT database(); 

-- create a table
CREATE TABLE table_name(
	column_name data_type, 
	column_name data_type
); 

-- list available tables in a database
SHOW TABLES; 

-- show columns and data types in a table
SHOW COLUMNS FROM table_name; OR
DESC table_name; 

-- drop a table
DROP TABLE table_name; 

-- add data into a table (the order matters)
INSERT INTO table_name(column1, column2)
VALUES (data1_1, data2_1),
       (data1_2, data2_2),
       (data1_3, data2_3);
-- e.g.
INSERT INTO cats(name, age) 
VALUES ('Charlie', 10),
       ('Sadie', 3),
       ('Lazy Bear', 1);

-- show all data in a table
SELECT * FROM table_name;

-- insert a string (VARCHAR) value that contains quotations
-- Escape the quotes with a backslash: 
"This text has \"quotes\" in it" or 'This text has \'quotes\' in it'
-- Alternate single and double quotes: 
"This text has 'quotes' in it" or 'This text has "quotes" in it'

-- get warning messages
SHOW WARNINGS;

-- create a table
CREATE TABLE cats(
     name VARCHAR(100),
     age INT
); -- NULL, NULL

-- create a table with NOT NULL constraints
CREATE TABLE cats2( 
     name VARCHAR(100) NOT NULL,
     age INT NOT NULL
); -- '', 0

-- create a table with default values
CREATE TABLE cats3( 
     name VARCHAR(100) DEFAULT 'unnamed',
     age  INT DEFAULT 99
); -- unnamed, 99; can still manually set values to NULL since did not specify NOT NULL
-- e.g. 
INSERT INTO cats3(name, age) 
VALUES(NULL, 3); -- NULL, 3

-- create a table with NOT NULL constraints and default values
CREATE TABLE cats4( 
     name VARCHAR(100) NOT NULL DEFAULT 'unnamed',
     age  INT NOT NULL DEFAULT 99
); -- unnamed, 99; cannot manually set values to NULL since specified NOT NULL

-- create a table with a PRIMARY KEY constraint (manually assign PK)
CREATE TABLE unique_cats(
     cat_id INT NOT NULL,
     name VARCHAR(100), 
     age INT,
     PRIMARY KEY (cat_id)
);

-- create a table with a PRIMARY KEY constraint (automatically assign PK)		     
CREATE TABLE unique_cats2(
     cat_id INT NOT NULL AUTO_INCREMENT,
     name VARCHAR(100), 
     age INT,
     PRIMARY KEY (cat_id)
);
