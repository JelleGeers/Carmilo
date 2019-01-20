let mongoose = require('mongoose');
let Ride= mongoose.model('Ride');
let User = mongoose.model("User")
let Passenger = mongoose.model("Passenger")
var express = require('express');
var router = express.Router();

router.get('/',function(req, res, next){
  
    User.aggregate([
      {
        "$project":{
          "_id":1,
          "name":1,
          "rides":1
        }
      },
      {
        "$unwind":"$rides"
      }
    ]).exec(function(err, rides) {
      if (err){
        return next(err);
      }
      console.log(rides)
      res.json(rides);
    });
})
router.get("/:username/rides",function(req,res,next){
  res.json(req.user.rides);
});

router.get("/:rideId/passengers",function(req,res,next){
  //res.json(req.ride);
});


router.post('/:username/rides', function (req, res, next){
  let user =req.user;
  user.rides.push(new Ride(req.body));
  user.save(function(err,rec){
    if(err){return next(err);}
    res.json(rec);
  });
});

router.param("username", function(req, res, next, id) {
  let query = User.findById(id);
  query.exec(function (err, user) {
    if (err) {
      return next(err);
    }
    console.log(user)
    if (!user) {
      return next(new Error('not found ' + id));
    }
  
    req.user = user;
    return next();
  });
});



//post
//rideId
//body: userId
router.post("/:uid/:riid", function(req, res, next){
  User.findOneAndUpdate(
    {
      _id: req.params.uid
     },
     {
       $push: {
         "rides.$[a].passengers": new Passenger({name: "RETARD "})
       }
     },
     {
       new: true,
       arrayFilters: [{'a._id': mongoose.Types.ObjectId(req.params.riid)}]
     }
).exec(function(err, user){
  console.log(user)
  res.json("test")
})
});

router.param("rideId",function(req, res, next, id){
  let query= Ride.findById(id);
  
  query.exec(function (err,ride){
    if (err){
      return next(err);
    }
    if(!ride){
      return next( new Error('not found '+ id));
    }
    req.ride= ride;
    return next();
  });
});
module.exports = router;