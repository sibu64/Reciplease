//
//  RecipeService.swift
//  reciplease
//
//  Created by Darrieumerlou on 01/11/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation

class RecipeService {
    static let shared = RecipeService()
    private init() {}

    private(set) var recipes: [Recipe] = []

    func add(recipe: Recipe) {
        recipes.append(recipe)
    }
   
    
}
