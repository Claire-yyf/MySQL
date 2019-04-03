-- 7-Data Types


-- 7-1-CHAR and VARCHAR

/*
CHAR has a fixed length e.g. CHAR(3) -> only 3 characters allowed, truncate if have more characters, add spaces if have less characters; faster for fixed length text e.g. Y/N, F/M
VARCHAR has a variable length; has more flexibily 
*/

CREATE TABLE dogs (name CHAR(5), breed VARCHAR(10)); -- name has exactly 5 characters, breed has up to 10 characters
INSERT INTO dogs (name, breed) VALUES ('bob', 'beagle');
INSERT INTO dogs (name, breed) VALUES ('robby', 'corgi');
INSERT INTO dogs (name, breed) VALUES ('Princess Jane', 'Retriever'); 
INSERT INTO dogs (name, breed) VALUES ('Princess Jane', 'Retrievesadfdsafdasfsafr'); -- truncated name and breed
SELECT * FROM dogs;


-- 7-2-DECIMAL 

/*
DECIMAL(maximum  number of digits, number of digits after decimal); fixed-point data type, calculations are exact
INT (whole numbers)
*/

CREATE TABLE items(price DECIMAL(5,2));
INSERT INTO items(price) VALUES(7); -- 7.00
INSERT INTO items(price) VALUES(7987654); -- 999.99 (value exceeds the maximum)
INSERT INTO items(price) VALUES(34.88); -- 34.88
INSERT INTO items(price) VALUES(298.9999); -- 299.00
INSERT INTO items(price) VALUES(1.9999); -- 2.0
SELECT * FROM items;


-- 7-3-FLOAT and DOUBLE

/*
FLOAT and DOUBLE- floating-point data type, calculations are approximate; store larger numbers using less space at the cost of precision
FLOAT- precision issues at ~7 digits
DOUBLE- precision issues at ~15 digits
*/

CREATE TABLE thingies (price FLOAT);
INSERT INTO thingies(price) VALUES (88.45); -- 88.45
INSERT INTO thingies(price) VALUES (8877.45); -- 8877.45
INSERT INTO thingies(price) VALUES (8877665544.45); -- 8877670000
SELECT * FROM thingies;


-- 7-4-DATE, TIME, and DATETIME

/*
DATE- values with date but no time; 'YYYY-MM-DD' format
TIME- values with time but no date; 'HH:MM:SS' format
DATETIME- values with date and time; 'YYYY-MM-DD HH:MM:SS' format
*/

CREATE TABLE people (name VARCHAR(100), birthdate DATE, birthtime TIME, birthdt DATETIME);
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Larry', '1943-12-25', '04:10:42', '1943-12-25 04:10:42');
SELECT * FROM people;


-- 7-5-CURDATE, CURTIME, and NOW

/*
CURDATE()- current date
CURTIME()- current time
NOW()- current date and time 
*/

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Blue', CURDATE(), CURTIME(), NOW());


-- 7-6-Formatting Dates

/*
DAY()- day of the month e.g. 21
DAYNAME()- day of the week e.g. Friday
DAYOFWEEK()- the nth day of the week e.g. 5  
DAYOFYEAR()- the nth day of the year e.g. 359
MONTH()- month of the year e.g. 2
MONTHNAME()- month of the year e.g. February 
HOUR()
MINUTE()  
DATE_FORMAT()
*/

SELECT name, birthdate, DAY(birthdate) FROM people;
SELECT name, birthdate, DAYNAME(birthdate) FROM people;
SELECT name, birthdate, DAYOFWEEK(birthdate) FROM people;
SELECT name, birthdate, DAYOFYEAR(birthdate) FROM people; 
SELECT name, birthtime, DAYOFYEAR(birthtime) FROM people;
SELECT name, birthdt, DAYOFYEAR(birthdt) FROM people;

SELECT name, birthdt, MONTH(birthdt) FROM people;
SELECT name, birthdt, MONTHNAME(birthdt) FROM people;

SELECT name, birthtime, HOUR(birthtime) FROM people;
SELECT name, birthtime, MINUTE(birthtime) FROM people;

SELECT CONCAT(MONTHNAME(birthdate), ' ', DAY(birthdate), ' ', YEAR(birthdate)) FROM people;
SELECT DATE_FORMAT(birthdt, 'Was born on a %W') FROM people;
SELECT DATE_FORMAT(birthdt, '%m/%d/%Y') FROM people;
SELECT DATE_FORMAT(birthdt, '%m/%d/%Y at %h:%i') FROM people;


-- 7-7-Date Math

/*
DATEDIFF(date1, date2)
DATEADD(date, INTERVAL expr unit)
DATESUB(date, INTERVAL expr unit)
*/

SELECT name, birthdate, DATEDIFF(NOW(), birthdate) FROM people; -- how many days ago was the person born
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 1 MONTH) FROM people; -- add 1 month to birth date
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 10 SECOND) FROM people; -- add 10 seconds to birth date
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 3 QUARTER) FROM people; -- add 3 quarters to birth date
SELECT birthdt, birthdt - INTERVAL 5 MONTH FROM people; -- subtract 5 months to birth date
SELECT birthdt, birthdt + INTERVAL 15 MONTH + INTERVAL 10 HOUR FROM people; -- add 15 months and 10 hours to birth date


-- 7-8-TIMESTAMPS

CREATE TABLE comments (
    content VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO comments (content) VALUES('lol what a funny article');
INSERT INTO comments (content) VALUES('I found this offensive');
INSERT INTO comments (content) VALUES('Ifasfsadfsadfsad'); 
SELECT * FROM comments ORDER BY created_at DESC;
 
CREATE TABLE comments2 ( 
    content VARCHAR(100),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
);
-- OR
CREATE TABLE comments2 (
    content VARCHAR(100),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
);
INSERT INTO comments2 (content) VALUES('dasdasdasd');
INSERT INTO comments2 (content) VALUES('lololololo');
INSERT INTO comments2 (content) VALUES('I LIKE CATS AND DOGS');
UPDATE comments2 SET content='THIS IS NOT GIBBERISH' WHERE content='dasdasdasd';
SELECT * FROM comments2 ORDER BY changed_at;


-- 175. Data Types Exercises

/*
What's a good use case for CHAR?
Used for text that we know has a fixed length, e.g., State abbreviations, 
abbreviated company names, sex M/F, etc.
*/
 
/*
What's the difference between DATETIME and TIMESTAMP?
They both store datetime information, but there's a difference in the range.
TIMESTAMP has a smaller range. TIMESTAMP also takes up less space. 
TIMESTAMP is used for things like meta-data about when something is created or updated.
*/

CREATE TABLE inventory (
    item_name VARCHAR(100),
    price DECIMAL(8,2), -- price is always < 1,000,000 so maximun price is 999,999.99
    quantity INT
);
 
SELECT CURTIME(); -- Print Out The Current Time
SELECT CURDATE(); -- Print Out The Current Date (but not time)
 
SELECT DAYOFWEEK(CURDATE()); -- Print Out The Current Day Of The Week (the number)
SELECT DAYOFWEEK(NOW());
SELECT DATE_FORMAT(NOW(), '%w') + 1; -- 0 is Sunday, 6 is Saturday
 
SELECT DAYNAME(NOW()); -- Print Out The Current Day Of The Week (the day name)
SELECT DATE_FORMAT(NOW(), '%W');
 
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y'); -- Print out the current day and time using this format: mm/dd/yyyy/
SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i'); -- Print out the current day and time using this format: January 2nd at 3:15, April 1st at 10:18
 
CREATE TABLE tweets(
    content VARCHAR(140),
    username VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);
INSERT INTO tweets (content, username) VALUES('this is my first tweet', 'coltscat');
INSERT INTO tweets (content, username) VALUES('this is my second tweet', 'coltscat');
SELECT * FROM tweets;
