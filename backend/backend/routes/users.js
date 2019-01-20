let mongoose = require('mongoose');
var express = require('express');
var router = express.Router();
let User= mongoose.model('User');
/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;

router.post('/',function(req,res,next){
    let user=new User(req.body);
    user.save(function (err, user) {
      if (err) {
        return next(err);
      }
      res.json(user);
    });
});