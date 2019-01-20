let mongoose = require('mongoose');

let Address= require('./Address');
let Passenger= require('./Passenger');

let RideSchema= new mongoose.Schema({
    
    departure:String,
    date: String,
    passengers: [Passenger],
    address: Address,
    maxPassengers:String
});
mongoose.model('Ride',RideSchema);





/*
Ride
name
rideInfo : Object

RideInfo
destination
date
address : Object

Address*/