-- 9-One To Many


-- Foreign Keys

-- creating the customers and orders tables
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- inserting some customers and orders
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);
       
-- this INSERT fails because of our fk constraint, no user with id: 98
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/06/06', 33.67, 98);


-- Cross Joins

-- Finding Orders Placed By George: 2 Step Process
SELECT id FROM customers WHERE last_name='George';
SELECT * FROM orders WHERE customer_id = 1;

-- Finding Orders Placed By George: Using a subquery
SELECT * FROM orders WHERE customer_id =
    (
        SELECT id FROM customers
        WHERE last_name='George'
    );

-- Cross Join Craziness
SELECT * FROM customers, orders; -- meanningless


-- Inner Joins (select all records from A and B where the join condition is met)

-- IMPLICIT INNER JOIN
SELECT * FROM customers, orders 
WHERE customers.id = orders.customer_id;
    
-- EXPLICIT INNER JOINS
SELECT * FROM customers
INNER JOIN orders ON customers.id = orders.customer_id; -- starts with customers 
SELECT * FROM orders
INNER JOIN customers ON customers.id = orders.customer_id; -- starts with orders

-- ARBITRARY JOIN - meaningless, but still possible 
SELECT * FROM customers
JOIN orders ON customers.id = orders.id;

-- Getting Fancier
SELECT first_name, last_name, order_date, amount 
FROM customers
JOIN orders ON customers.id = orders.customer_id
ORDER BY order_date;

SELECT 
    first_name, 
    last_name, 
    SUM(amount) AS total_spent
FROM customers 
JOIN orders ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;


-- Left Joins (select everything from A, along with any matching records in B)

SELECT * FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;

SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;


-- Right Joins (select everything from B, along with any matching records in A)

SELECT * FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

SELECT 
    IFNULL(first_name,'MISSING') AS first, 
    IFNULL(last_name,'USER') AS last,
    SUM(amount)
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id
GROUP BY customer_id;

-- WORKING WITH ON DELETE CASCADE
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
); 
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) 
        REFERENCES customers(id)
        ON DELETE CASCADE -- when a customer with corresponding orders was deleted, delete the orders as well
);

SELECT * FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id; -- customers first, then orders
-- is the same as
SELECT * FROM orders
RIGHT JOIN customers ON customers.id = orders.customer_id; -- orders first, then customers

SELECT * FROM orders
LEFT JOIN customers ON customers.id = orders.customer_id; -- orders first, then customers
-- is the same as
SELECT * FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id; -- customers first, then orders


-- 218. Joins Exercises

-- The Schema
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100)
);
CREATE TABLE papers (
    title VARCHAR(100),
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id) 
        REFERENCES students(id)
        ON DELETE CASCADE
);

-- The Starter Data
INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa'); 
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT first_name, title, grade
FROM students INNER JOIN papers ON students.id = papers.student_id
ORDER BY grade DESC;
-- alt solution
SELECT first_name, title, grade
FROM students RIGHT JOIN papers ON students.id = papers.student_id
ORDER BY grade DESC;

SELECT first_name, title, grade
FROM students LEFT JOIN papers ON students.id = papers.student_id;

SELECT first_name, 
        IFNULL(title, 'MISSING') AS title,
        IFNULL(grade, 0) AS grade
FROM students LEFT JOIN papers ON students.id = papers.student_id;

SELECT first_name, 
        IFNULL(AVG(grade), 0) AS average
FROM students LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

SELECT first_name, 
        IFNULL(AVG(grade), 0) AS average,
        CASE 
            WHEN AVG(grade) IS NULL THEN 'FAILING'
            WHEN AVG(grade) >= 75 THEN 'PASSING' 
            ELSE 'FAILING'
        END AS passing_status
FROM students LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;
