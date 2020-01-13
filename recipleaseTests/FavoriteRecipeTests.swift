//
//  FavoriteRecipeTests.swift
//  recipleaseTests
//
//  Created by Darrieumerlou on 08/01/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
import CoreData
@testable import reciplease

class FavoriteRecipeTests: XCTestCase {
     /*creating a CoreDataManager object, we will use this object to test operations like insert, delete*/
      internal var recipes: [Recipe]!
      var coreDataManager: CoreDataManager!
        
        override func setUp() {
            super.setUp()
            // Put setup code here. This method is called before the invocation of each test method in the class.
          coreDataManager = CoreDataManager.sharedManager
        }
        
        override func tearDown() {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
            super.tearDown()
        }
        
        func testPerformanceExample() {
            // This is an example of a performance test case.
            self.measure {
                // Put the code you want to measure the time of here.
            }
        }
        
      // MARK: The test cases
      
      /*this test case test for the proper initialization of CoreDataManager class :)*/
        func test_init_coreDataManager(){
          
          let instance = CoreDataManager.sharedManager
          /*Asserts that an expression is not nil.
           Generates a failure when expression == nil.*/
          XCTAssertNotNil( instance )
        }
      
      /*test if NSPersistentContainer(the actual core data stack) initializes successfully
       */
      func test_coreDataStackInitialization() {
        let coreDataStack = CoreDataManager.sharedManager.persistentContainer
        
        /*Asserts that an expression is not nil.
         Generates a failure when expression == nil.*/
        XCTAssertNotNil( coreDataStack )
      }
        
      //This test case fetches all person records
        func test_fetch_all_recipes() {

          //get reicpeRecord already saved

          let results = coreDataManager.fetchAllRecipes()

          //Assert return numbers of todo items
          //Asserts that two optional values are equal.
          XCTAssertEqual(results?.count, 0)
        }
      func test_remove_recipe() {
        
        /*fetch all items*/
        let items = coreDataManager.fetchAllRecipes()
        /*get first item*/
        let favoriteRecipe = items![0]
        
        /*total numbers of items*/
        let numberOfItems = items?.count
        
        //remove a item
        coreDataManager.delete(recipe: favoriteRecipe)
        
        //Assert number of item - 1. That is after deleting a item, sut.fetchAllPersons()?.count should be equal to numberOfItems!-1.
        XCTAssertEqual(coreDataManager.fetchAllRecipes()?.count, numberOfItems!-1)
      }
    
      /*test if all data is deleted from store*/
//      func test_flushData() {
//        coreDataManager.flushData()
//
//       /*this test case passes if fetchAllPerson returns 0 objects*/ XCTAssertEqual(coreDataManager.fetchAllPersons()?.count, 0)
//      }
      
}
