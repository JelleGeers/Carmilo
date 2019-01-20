var mongoose= require('mongoose');

var AddressSchema= new mongoose.Schema({
    street: String,
    houseNr: String,
    zipcode: String,
});
mongoose.model('Address',AddressSchema)