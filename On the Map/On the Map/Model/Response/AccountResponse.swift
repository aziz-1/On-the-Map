//
//  AccountResponse.swift
//  On the Map
//
//  Created by Reem Aldughaither on 5/7/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

struct AccountResponse: Codable {
    let registered: Bool?
    let key: String?
    
    enum CodingKeys: String, CodingKey {
        case registered
        case key
    }
}
