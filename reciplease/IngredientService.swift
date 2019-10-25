//
//  IngredientService.swift
//  reciplease
//
//  Created by Darrieumerlou on 22/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation

class IngredientService {
    static let shared = IngredientService()
    private init() {}

    private(set) var ingredients: [Ingredient] = []

    func add(ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
}
