//
//  User.swift
//  Carmilo
//
//  Created by Jelle Geers on 22/12/2018.
//  Copyright © 2018 Jelle Geers. All rights reserved.
//

import Foundation
struct User : Decodable, Encodable {
    let name: String
    let email: String
    let ride: String
}
