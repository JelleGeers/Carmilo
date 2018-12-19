//
//  RideInfo.swift
//  Carmilo
//
//  Created by Jelle Geers on 18/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//

import Foundation
struct RideInfo : Decodable, Encodable{
    let departure : String
    let date : String
    let passengers:[Passenger]
    let address: Address
    let maxPassengers:String
}
