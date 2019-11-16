//
//  APIingredients.swift
//  reciplease
//
//  Created by Darrieumerlou on 29/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation
import Alamofire

class APIIngredients: Decodable {
    func execute(_ ingredients: [String], completion: @escaping (([Recipe]) -> ())) {
        do {
            let request = try Router.search(ingredients: ingredients).asURLRequest()
            Alamofire.request(request).responseJSON { response in
            print(response)
            }
        } catch {
            print("Error:\(error)")
        }
    }
}
