//
//  apiTests.swift
//  recipleaseTests
//
//  Created by Darrieumerlou on 26/12/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import reciplease

class ApiTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_api_ingredient_hasBeenCalled() {
        let api = MockApiIngredient()
        
        api.get(["lemon"], completion: nil)
        
        XCTAssertEqual(api.countCalled, 1)
        XCTAssertEqual(api.params?.first, "lemon")
    }
    
    func test_api_ingredient_success_call() {
        let api = StubApiIngredient()
        
        var recipe: Recipe?
        api.get(["lemon"]) { models in
            recipe = models.first
        }
        
        XCTAssertEqual(recipe, Recipe.fake)
    }
}
