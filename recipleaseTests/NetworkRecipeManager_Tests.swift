//
//  NetworkRecipeManager_Tests.swift
//  recipleaseTests
//
//  Created by Darrieumerlou on 20/01/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import reciplease

class NetworkRecipeManager_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_manager_hasBeenCalled() {
        let mock = MockApiIngredient()
        let manager = NetworkRecipeManager(api: mock)
        
        manager.get(ingredients: ["lemon"], completion: nil)
        
        XCTAssertEqual(mock.params?.first, "lemon")
        XCTAssertEqual(mock.countCalled, 1)
    }
    
    func test_manager_calls_success() {
        let stub = StubApiIngredient()
        let manager = NetworkRecipeManager(api: stub)
        
        var recipe: Recipe? = nil
        manager.get(ingredients: ["lemon"]) { recipes in
            recipe = recipes.first
        }
        
        XCTAssertEqual(recipe, Recipe.fake)
    }
    
    func test_manager_with_default_value() {
        let manager = NetworkRecipeManager.default
        
        let api = manager.api is APIIngredients
        
        XCTAssertTrue(api)
    }

}
