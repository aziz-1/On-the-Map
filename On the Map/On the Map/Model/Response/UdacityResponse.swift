//
//  UdacityResponse.swift
//  On the Map
//
//  Created by Reem Aldughaither on 5/7/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

struct UdacityResponse: Codable {
    let account: AccountResponse?
    let session: session?
    let status: Int?
    let error: String?


    
    enum CodingKeys: String, CodingKey {
        
        case account
        case session
        case status
        case error
        
    }
}
