//
//  Address.swift
//  Carmilo
//
//  Created by Jelle Geers on 18/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//

import Foundation
struct Address : Decodable, Encodable {
    let street: String
    let houseNr: String
    let zipcode: String
}
