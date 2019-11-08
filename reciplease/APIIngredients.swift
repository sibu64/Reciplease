//
//  APIingredients.swift
//  reciplease
//
//  Created by Darrieumerlou on 29/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation
import Alamofire

class APIIngredients: Decodable
{
    
    var ingredients: [String] = []
    
    static let shared: APIIngredients? = nil
    
    typealias WebServiceResponse = ([[String: Any]]?, Error?) -> Void
    
    var baseUrl = "https://api.edamam.com/search?"
    
//    var url = "https:api.edamam.com/search?q="+ingredients.joined()+"&app_id="+Constants.edamam_api_id+"&app_key="+Constants.edamam_api_key+"&from=0&to=3&calories=591-722&health=alcohol-free"

//    func connexionToRecipes() { Alamofire.request("https:api.edamam.com/search?q=chicken&app_id="+Constants.edamam_api_id+"&app_key="+Constants.edamam_api_key+"&from=0&to=3&calories=591-722&health=alcohol-free",method: .post).responseString { response in



//"https:api.edamam.com/search?q=chicken&app_id=6a8405b5&app_key=53f7376ae74f62ffa5beffdb4332a83f"
//}
    func execute(_ ingredients: [String], completion: @escaping (([Recipe]) -> ())) {
        self.ingredients = ingredients
        let request = buildRequest()
        Alamofire.request(request).responseJSON { response in
            print(response)
            completion([])
        }
//        Alamofire.request(url).validate().responseJSON { response in
//        print(response)
//            if let error = response.error{
//                completion(nil, error)
//            }
//            else if let jsonArray = response.result.value as? [[String: Any]] {
//                 completion(jsonArray, nil)
//            }
//            else if let jsonDict = response.result.value as? [String: Any] {
//                completion([jsonDict], nil)
//            }
//    }
    }
    
    init() {
    }

    
    
    internal func buildRequest() -> URLRequest {
        
        var urlComponents = URLComponents(string: baseUrl)!
        
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "q", value: ingredients.joined(separator: ",")))
        queryItems.append(URLQueryItem(name: "app_id", value: Constants.app_id))
        queryItems.append(URLQueryItem(name: "app_key", value: Constants.app_key))
        
        urlComponents.queryItems = queryItems
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        return urlRequest
        
    }
}
