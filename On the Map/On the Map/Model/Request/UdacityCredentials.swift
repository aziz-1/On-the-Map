//
//  UdacityCredentials.swift
//  On the Map
//
//  Created by Reem Aldughaither on 5/7/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

struct UdacityCredentials: Codable {
    let udacity: [String:String]


    init(username: String, password: String) {
        let newUdacity = ["username": username, "password": password]
        self.udacity = newUdacity
    }
    
    enum CodingKeys: String, CodingKey {

        case udacity
    }
}
