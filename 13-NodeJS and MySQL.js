// 13-NodeJS and MySQL


// execute the node.js file
node filename.js

// stop node.js
control + C

// print "HELLO WORLD" 500 times using Node
for (var i = 0; i < 500; i++) {
  console.log("HELLO WORLD!");
}


// 1. Introduction to NPM (node package manager) and Faker ------------------------------

// Install Faker via command line
npm install faker
// Require it inside of a JS file
var faker = require('faker');

// Print a random email
console.log(faker.internet.email());
// Print a random past date
console.log(faker.date.past());
// Print a random city
console.log(faker.address.city());

// Define a new function
function generateAddress() {
  console.log(faker.address.streetAddress());
  console.log(faker.address.city());
  console.log(faker.address.state());
}
// And then execute that function
generateAddress();


// 2. Connecting Node to MySQL ------------------------------

// Install the MySQL Node Package 
npm install mysql

// Connect to Database 
var mysql = require('mysql');
var connection = mysql.createConnection({
  host: 'localhost',
  user: 'claireyyf',  //some username
  database: 'join_us'  //some database
});

// End connection 
connection.end();

// Running a super simple SQL query
SELECT 1 + 1;

// Using the MySQL Node Package
connection.query('SELECT 1 + 1 AS solution', function (error, result, fields) {
  if (error) throw error;
  console.log('The solution is: ', result[0].solution);
});

// Another sample query, this time selecting 3 things
var q = 'SELECT CURTIME() as time, CURDATE() as date, NOW() as now';
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result[0].time);
  console.log(result[0].date);
  console.log(result[0].now);
});

// The equivalent SQL query
SELECT CURTIME() as time, CURDATE() as date, NOW() as now;

// Use SQL to create the users table
CREATE TABLE users(
  email VARCHAR(255) PRIMARY KEY,
  created_at TIMESTAMP DEFAULT NOW()
);
// Insert users 
INSERT INTO users(email) VALUES('Katie34@yahoo.com'), ('Tunde@gmail.com');
// Check that users are added 
SELECT * FROM users;


// 3. Selecting Using Node ------------------------------

// To SELECT all users from database
var q = 'SELECT * FROM users';
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result[0].email);
});
var q = 'SELECT * FROM users';
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result.map(e => e.email));
});

// To COUNT the number of users in the database
var q = 'SELECT COUNT(*) AS total FROM users';
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result[0].total);
});


// 4. Inserting Using Node ------------------------------

// Approach 1
var q = 'INSERT INTO users (email) VALUES ("rusty_the_dog@gmail.com")';
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result);
});

// An easier approach that allows for dynamic data
var person = {
  email: faker.internet.email(),
  created_at: faker.date.past()
};
var end_result = connection.query('INSERT INTO users SET ?', person, function (err, result) {
  if (err) throw err;
  console.log(result);
});


// 5. To INSERT 500 Random Users ------------------------------

var mysql = require('mysql'), faker = require('faker');

var connection = mysql.createConnection({
  host: 'localhost',
  user: 'claireyyf',
  database: 'join_us'
});

// var data = [
//   ['blah@gmail.com', '2017-05-01 03:51:37'],
//   ['ugh@gmail.com', '2017-05-01 03:51:37'],
//   ['meh@gmail.com', '2017-05-01 03:51:37']
// ];

// var q = 'INSERT INTO users (email, created_at) VALUES ?';

// connection.query(q, [data], function(err, result) {
// console.log(err);
// console.log(result);
// });

var data = [];
for (var i = 0; i < 500; i++) {
  data.push([
    faker.internet.email(),
    faker.date.past()
  ]);
}

var q = 'INSERT INTO users (email, created_at) VALUES ?';

connection.query(q, [data], function (err, result) {
  console.log(err);
  console.log(result);
});

connection.end();


// 6. 500 Users Exercises ------------------------------

// Find Earliest Date A User Joined
SELECT DATE_FORMAT(MIN(created_at), "%M %D %Y") AS earliest_date FROM users;
//OR SELECT * FROM users ORDER BY created_at LIMIT 1;

var q = 'SELECT DATE_FORMAT(MIN(created_at), "%M %D %Y") AS earliest_date FROM users';
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result);
});

// Find Email Of The First (Earliest) User
SELECT * FROM users WHERE created_at = (SELECT MIN(created_at) AS earliest_date FROM users);

var q = 'SELECT * FROM users WHERE created_at = (SELECT MIN(created_at) AS earliest_date FROM users)';
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result);
});

// Count Users According To The Month They Joined
SELECT MONTHNAME(created_at) AS month, COUNT(*) AS count FROM users
GROUP BY month
ORDER BY count DESC;

var q = 'SELECT MONTHNAME(created_at) AS month, COUNT(*) AS count FROM users GROUP BY month ORDER BY count DESC;';
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result);
});

// Count Number of Users With Yahoo Emails
SELECT COUNT(*) AS yahoo_user FROM users WHERE email LIKE "%@yahoo.com";

var q = 'SELECT COUNT(*) AS yahoo_user FROM users WHERE email LIKE "%@yahoo.com"';
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result);
});

// Calculate Total Number of Users for Each Email Host
SELECT CASE
WHEN email LIKE '%@gmail.com' THEN 'gmail'
WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
ELSE 'other'
END AS provider, COUNT(*) AS total_users
FROM users
GROUP BY provider
ORDER BY total_users DESC;

var q = "SELECT CASE WHEN email LIKE '%@gmail.com' THEN 'gmail' WHEN email LIKE '%@yahoo.com' THEN 'yahoo' WHEN email LIKE '%@hotmail.com' THEN 'hotmail' ELSE 'other' END AS provider, COUNT(*) AS total_users FROM users GROUP BY provider ORDER BY total_users DESC";
connection.query(q, function (error, result, fields) {
  if (error) throw error;
  console.log(result);
});
