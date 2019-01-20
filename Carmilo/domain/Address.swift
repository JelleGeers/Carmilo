import Foundation
struct Address : Decodable, Encodable {
    let street: String
    let houseNr: String
    let zipcode: String
}
