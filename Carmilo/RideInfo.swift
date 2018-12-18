//
//  RideInfo.swift
//  Carmilo
//
//  Created by Jelle Geers on 18/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//

import Foundation
struct RideInfo : Decodable, Encodable{
    let destination : String
    let date : String
    let address: Address
}
