import Foundation
struct RideInfo : Decodable, Encodable{
    let departure : String
    let date : String
    let passengers:[Passenger]
    let address: Address
    let maxPassengers:String
}
