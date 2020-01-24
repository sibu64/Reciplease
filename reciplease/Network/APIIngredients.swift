//
//  APIingredients.swift
//  reciplease
//
//  Created by Darrieumerlou on 29/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation
import Alamofire

class APIIngredients: NetworkRequestProtocol {
     func get(_ ingredients: [String], completion: RecipeResults?) {
        do {
            let request = try Router.search(ingredients: ingredients).asURLRequest()
            Alamofire.request(request).responseJSON { response in
                if let responseData = response.data{
                    let decoder = JSONDecoder()
                    do {
                        let model = try decoder.decode(Welcome.self, from: responseData)
                        let recipes = model.hits.map { $0.recipe }
                        completion?(recipes)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
        } catch {
            print("Error:\(error)")
        }
    }
}
