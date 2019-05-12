//
//  Student.swift
//  On the Map
//
//  Created by Reem Aldughaither on 5/5/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation


struct StudentRequest: Codable {
  
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let ACL: ACL?
    
    init(uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double) {
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mapString = mapString
        self.mediaURL = mediaURL
        self.latitude = latitude
        self.longitude = longitude
        self.ACL = nil

    }
    
    enum CodingKeys: String, CodingKey {

        case uniqueKey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude
        case longitude
        case ACL
    }
    
}
