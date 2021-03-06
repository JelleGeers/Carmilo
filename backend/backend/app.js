//first, we need to connect to our database==> import the mongoose library
var mongoose= require('mongoose');

//we first need to register these schema's we do this by importing the definitions, making them accessible
require('./models/User');
//connect to our database, call connect, with the url of the database
mongoose.connect('mongodb://localhost/applicationdb', {useNewUrlParser: true});

var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/API/rides', indexRouter);
app.use('/API/users', usersRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
console.log(err.message)
  // render the error page
  res.status(err.status || 500);
  res.send('error');
});
module.exports = app;