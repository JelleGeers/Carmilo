let mongoose = require('mongoose');


let PassengerSchema = new mongoose.Schema({
    name: String,
    street:String,
    houseNr: String,
    village: String,
    age: String
});
mongoose.model('Passenger',PassengerSchema);