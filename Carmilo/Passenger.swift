//
//  Passenger.swift
//  Carmilo
//
//  Created by Jelle Geers on 18/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//

import Foundation
struct Passenger:Decodable, Encodable{
    let name: String
    let street: String
    let houseNr: String
    let village: String
    let age: String
}
