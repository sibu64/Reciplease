//
//  APIingredients.swift
//  reciplease
//
//  Created by Darrieumerlou on 29/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation
import Alamofire

class APIIngredients {//: NetworkRequest {
    
//    func get<DataType>(_ url: URL, with: [String : Any], completion: @escaping (DataType?, Error?) -> Void) where DataType : Decodable, DataType : Encodable {
//
//    }
    
//    private let manager: SessionManager
//    init(manager: SessionManager = SessionManager.default) {
//        self.manager = manager
//    }
//
    func execute(_ ingredients: [String], completion: @escaping (([Recipe]) -> ())) {
        do {
            let request = try Router.search(ingredients: ingredients).asURLRequest()
            Alamofire.request(request).responseJSON { response in
                if let responseData = response.data{
                   let decoder = JSONDecoder()
                    do {
                        let model = try decoder.decode(Welcome.self, from: responseData)
                        let recipes = model.hits.map { $0.recipe }
                        completion(recipes)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            //print(response)
            }
        } catch {
            print("Error:\(error)")
        }
    }
}

