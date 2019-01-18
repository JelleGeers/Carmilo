//
//  Ride.swift
//  Carmilo
//
//  Created by Jelle Geers on 18/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//

import Foundation
struct Ride: Decodable , Encodable{
    let name : String
    let rides : RideInfo
}
