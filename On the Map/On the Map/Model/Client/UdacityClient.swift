//
//  UdacityClient.swift
//  On the Map
//
//  Created by Reem Aldughaither on 5/5/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

class UdacityClient {

    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case session
        case getUser(String)
        
        var stringValue: String{
            switch self {
            case .session:
                return Endpoints.base + "/session"
            case .getUser(let user):
                return Endpoints.base + "/users/" + user
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
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
    
    
    class func taskForPostRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
       var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
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
                let range = Range(5..<data.count)
                let newData = data.subdata(in: range)
                
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
               
                DispatchQueue.main.async {
                    
                    completion(responseObject, nil)
                }
            } catch {
                
               
                completion(nil, error)
                
            }
        }
        
        task.resume()
    }
    
    class func login(credentials: UdacityCredentials, completion: @escaping (UdacityResponse?, Error?) -> Void) {
        taskForPostRequest(url: Endpoints.session.url, responseType: UdacityResponse.self, body: credentials) { (response, error) in
            if let response = response {
                completion(response, nil)
                
            }
            else {
                completion(nil, error)
            }

            
        }
    }
    
    class func deleteSession(completion: @escaping (Data?, Error?) -> Void)  {
        var request = URLRequest(url: Endpoints.session.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
            DispatchQueue.main.async {
                completion(data, nil)
            }
            
        }
        task.resume()
        
    }
        
    
}
