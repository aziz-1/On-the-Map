//
//  session.swift
//  On the Map
//
//  Created by Reem Aldughaither on 5/7/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
struct session: Codable {
    let id: String?
    let expiration: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case expiration
}
}
