//
//  APIIngredientsFake.swift
//  recipleaseTests
//
//  Created by Darrieumerlou on 29/12/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation
@testable import reciplease

class MockApiIngredient: NetworkRequestProtocol {
    private(set) var countCalled: NSInteger = 0
    private(set) var params: [String]?
    
    func get(_ ingredients: [String], completion: RecipeResults?) {
        self.countCalled += 1
        self.params = ingredients
    }
}

class StubApiIngredient: NetworkRequestProtocol {
    func get(_ ingredients: [String], completion: RecipeResults?) {
        let data = Data.from("search")
        
        do {
            let welcome = try Welcome(data: data)
            //let object = try JSONDecoder().decode(Welcome.self, from: data)
            let recipes = welcome.hits.map { $0.recipe }
            completion?(recipes)
        } catch let error {
            print("Error: \(error)")
        }
        
    }
}

extension Recipe {
    static var fake: Recipe {
        let ingredient = Ingredient(text: "lemon", quantity: 1, measure: "lemonmeasure", food: "lemonfood", weight: 10.5)
        
        let model = Recipe(
            uri: "uri",
            label: "label",
            image: "https://image.com",
            url: "url",
            yield: 0,
            ingredientLines: ["lemon"],
            ingredients: [ingredient],
            totalTime: 160
        )
        return model
    }
}
