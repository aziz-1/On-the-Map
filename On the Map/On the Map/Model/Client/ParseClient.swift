//
//  ParseClient.swift
//  On the Map
//
//  Created by Reem Aldughaither on 5/5/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

class ParseClient {
    
    static let applicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    enum Endpoints {
        static let base = "https://parse.udacity.com/parse/classes"
        
        case getAllStudentLocation
        case getSingleStudentLocation(String)
        
        var stringValue: String{
            switch self {
            case .getAllStudentLocation:
                return Endpoints.base + "/StudentLocation?limit=100&&order=-updatedAt"
            case .getSingleStudentLocation( let query):
                return Endpoints.base + "/StudentLocation" + "?where=%7B%22uniqueKey%22%3A%22\(query)%22%7D"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.addValue(applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                
                let responseObject = try decoder.decode(ResponseType.self, from: data)
               
                DispatchQueue.main.async {
                 
                    completion(responseObject, nil)
                }
            } catch {
               
                        completion(nil, error)
                
            }
        }
        task.resume()
        
        return task
    }
    

    class func taskForPostPutRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, method: String, objectId: String, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request: URLRequest
        
        if method == "PUT" {
        let newURL = URL(string: Endpoints.base + "/StudentLocation/" + objectId)
           
        request = URLRequest(url: newURL!)
        }
        else {
        request = URLRequest(url: url)
        }
       
        request.addValue(applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(apiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.httpMethod = method
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
     
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                   
                    completion(nil, error)
                   
                }
                return
            }
            let decoder = JSONDecoder()
        
            do {
                
            
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                
                DispatchQueue.main.async {
               
                    completion(responseObject, nil)
                }
            } catch {
            
                
                        completion(nil, error)
                
                }
            }
       
        task.resume()
    }
    
    class func getStudentsLocations(completion: @escaping ([StudentLocation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getAllStudentLocation.url, responseType: StudnetLocationResult.self) { (response
            , error) in
            if let response = response {
              
                completion(response.results, nil)
            }
            else {
                completion([], error)
            }
            
        }
    }

    class func getStudentsLocation(id: String, completion: @escaping ([StudentLocation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getSingleStudentLocation(id).url, responseType: StudnetLocationResult.self) { (response
            , error) in
            if let response = response {
                
                completion(response.results, nil)
            }
            else {
                completion([], error)
            }
            
        }
    }
    
    class func addStudnet(student: StudentRequest, completion: @escaping (StudentLocation?, Error?) -> Void) {
        
       
        taskForPostPutRequest(url: Endpoints.getAllStudentLocation.url
        , method: "POST", objectId: "", responseType: StudentLocation.self, body: student) { (response, error) in
            if let response = response {
               
                completion(response, nil)
            }
            
            else {
                completion(response, error)
            }
          
        }
    }
    
    class func updateStudent(objectId: String, updatedStudnet: StudentRequest, completion: @escaping (StudentLocation, Error?) -> Void) {
        
        
        taskForPostPutRequest(url: Endpoints.getAllStudentLocation.url
        , method: "PUT", objectId: objectId, responseType: StudentLocation.self, body: updatedStudnet) { (response, error) in
            if let response = response {
                
                completion(response, nil)
            }
        }
    }
}
