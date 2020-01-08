//
//  protocol_alamofire.swift
//  recipleaseTests
//
//  Created by Darrieumerlou on 24/12/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit
import Foundation

enum NetworkRequestError: Error {
    case statusCode(Int)
    case serializationError(Error?)
}
 
protocol NetworkRequestProtocol {
    func get<Recipe: Codable>(_ url: URL, with: [String: Any], completion: @escaping (Recipe?, Error?) -> Void)
}
 
 
class AlamofireNetworkRequest: NetworkRequestProtocol {
    func get<Recipe: Codable>(_ url: URL, with: [String: Any], completion: @escaping (Recipe?, Error?) -> Void) {
        // Do whatever needed with Alamofire
    }
}
 
struct FakeNetworkRequest: NetworkRequestProtocol {
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
    
    func get<Recipe: Codable>(_ url: URL, with: [String: Any], completion: @escaping (Recipe?, Error?) -> Void) {
        guard let response = response, response.statusCode == 200 else {
            return completion(nil, NetworkRequestError.statusCode(self.response?.statusCode ?? -1))
        }
        guard let data = data else {
            return completion(nil, error)
        }
        
        do {
            completion(try JSONDecoder().decode(Recipe.self, from: data), nil)
        } catch {
            completion(nil, NetworkRequestError.serializationError(error))
        }
    }
}
