//
//  Student.swift
//  On the Map
//
//  Created by Reem Aldughaither on 5/5/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation


struct StudentLocation: Codable {
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: String?
    let updatedAt: String?
    let ACL: ACL?
    let code: Int?
    let error: String?
    
    init(uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double) {
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mapString = mapString
        self.mediaURL = mediaURL
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = nil
        self.updatedAt = nil
        self.ACL = nil
        self.objectId = ""
        self.code = nil
        self.error = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case objectId
        case uniqueKey
        case firstName
        case lastName
        case mapString
        case mediaURL
        case latitude
        case longitude
        case createdAt
        case updatedAt
        case ACL
        case code
        case error
    }

}
