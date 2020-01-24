//
//  NetworkRecipeManager.swift
//  reciplease
//
//  Created by Darrieumerlou on 17/01/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

class NetworkRecipeManager {
    var api: NetworkRequestProtocol?
       
    init(api: NetworkRequestProtocol?){
        self.api = api
    }

    func get(ingredients: [String], completion: RecipeResults?){
        api?.get(ingredients, completion: completion)
    }
}
  
extension NetworkRecipeManager {
    public static var `default`: NetworkRecipeManager {
        return NetworkRecipeManager(api: APIIngredients())
    }
}
