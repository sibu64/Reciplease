//
//  Router.swift
//  reciplease
//
//  Created by Darrieumerlou on 12/11/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Alamofire


enum Router: URLRequestConvertible {
    
    case search(ingredients: [String])
    
    
    static let baseURLString = "https://api.edamam.com"
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search( _):
            return "search"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        let urlPath = url.appendingPathComponent(path)
        
        switch self {
        case .search(let ingredients):
            var urlComponents = URLComponents(url: urlPath, resolvingAgainstBaseURL: false)!
            var queryItems = [URLQueryItem]()
            queryItems.append(URLQueryItem(name: "q", value: ingredients.joined(separator: ",")))
            queryItems.append(URLQueryItem(name: "app_id", value: Constants.app_id))
            queryItems.append(URLQueryItem(name: "app_key", value: Constants.app_key))
            
            urlComponents.queryItems = queryItems
            
           return URLRequest(url: urlComponents.url!)
        }
        
    }
}
