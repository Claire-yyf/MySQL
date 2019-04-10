// 14-Express, MySQL and Web APP


// a fast way of starting a new app
npm init
// save a record of the install
npm install express--save
// start the server up:
node app.js
// nodemon
npm install nodemon--save


// 1. Simple Web App (add to the app.js file) ------------------------------

var express = require('express');
var app = express();

app.get("/", function (req, res) {
  res.send("HELLO FROM OUR WEB APP!");
});

app.listen(8080, function () {
  console.log('App listening on port 8080!');
});


// 2. Adding Multiple Routes ------------------------------

// Add a /joke route
app.get("/joke", function (req, res) {
  var joke = "What do you call a dog that does magic tricks? A labracadabrador.";
  res.send(joke);
});

// Add a /random_num route
app.get("/random_num", function (req, res) {
  var num = Math.floor((Math.random() * 10) + 1);
  res.send("Your lucky number is " + num);
});


// 3. Connecting Express and MySQL ------------------------------

// Add the MySQL code inside of the root route 
var express = require('express');
var mysql = require('mysql');
var app = express();

var connection = mysql.createConnection({
  host: 'localhost',
  user: 'claireyyf',  //some username
  database: 'join_us'  //some database
});

// Retrieving Users Count From DB Inside a Route
app.get("/", function (req, res) {
  var q = 'SELECT COUNT(*) AS count FROM users';
  connection.query(q, function (error, result) {
    if (error) throw error;
    var msg = "We have " + result[0].count + " users";
    res.send(msg);
  });
});


// 4. Adding EJS (Embedded JavaScript) to Web App ------------------------------

// Install ejs and use css
npm install--save ejs
app.set("view engine", "ejs");
app.use(express.static(__dirname + "/public"));

app.get("/", function (req, res) {
  var q = 'SELECT COUNT(*) AS count FROM users';
  connection.query(q, function (error, result) {
    if (error) throw error;
    var count = result[0].count;
    res.render("home", { count: count });
  });
});

/* home.ejs
<h1>JOIN US</h1>
<p class="lead">Enter your email to join <strong><%=count%></strong>
    others on our waitlist. We are 100% not a cult.</p>
<form action='/register' method="POST"> // post request- send the user input to the /register route when user clicks the button (when the form is submitted)
    <input type="email" name="email" class="form" placeholder="Enter Your Email" required>
    <button>Join Now</button>
</form> 
*/


// 5. Connecting the Form (define a POST route) ------------------------------

// Install body-parser
npm install--save body - parser
var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: true }));

// The '/register' post route
app.post('/register', function (req, res) {
  var person = { email: req.body.email }; // Extracting Form Data From Request Body
  connection.query('INSERT INTO users SET ?', person, function (error, result) {
    if (error) throw error;
    // res.send('Thanks for joining our waitlist!');
    res.redirect("/");
    // OR
    /*
      var q = "INSERT INTO users (email) VALUES (" + req.body.email + ")";
    connection.query(q, function (error, result) {
      if (error) throw error;
      res.redirect("/");
    */
  });
});

