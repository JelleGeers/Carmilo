var mongoose= require('mongoose');
let Ride= require('./Ride');


var UserSchema= new mongoose.Schema({
    //name:{type:String,unique: true},
    name:String,
    email:{type:String,unique:true},
    rides: [Ride]
});
mongoose.model('User',UserSchema)