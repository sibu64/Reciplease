//
//  FavoriteRecipeTests.swift
//  recipleaseTests
//
//  Created by Darrieumerlou on 15/01/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
import CoreData
@testable import reciplease

class FavoriteRecipesTests: XCTestCase {
        
    var sut: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        
        initStubs()
        sut = CoreDataManager(container: mockPersistantContainer)
        
        //Listen to the change in context
        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave , object: nil)
        
    }
    
    override func tearDown() {
        NotificationCenter.default.removeObserver(self)
        flushData()
        super.tearDown()
    }
    
    func test_create_recipe() {
        let model = sut.insertRecipe(identifier: "10", imageURL: "image", ingredients: "ingredient", isFavorite: true, totalTime: 10.0, name: "lemon")
        XCTAssertNotNil(model)
    }
    
    func test_fetch_all_favRecipes() {
        let results = sut.fetchAll

        XCTAssertEqual(results.count, 2)
    }
    
    func test_remove_recipe() {
        //Given a item in persistent store
        let items = sut.fetchAll
        let item = items[0]
        
        let numberOfItems = items.count
        
        //When remove a item
        sut.remove(objectID: item.objectID)
        sut.save()
        
        //Assert number of item - 1
        XCTAssertEqual(numberOfItemsInPersistentStore(), numberOfItems-1)
    }
    
    func test_find_recipe_and_convert_to_favoriteRecipe() {
        let recipe = Recipe(uri: "uri", label: "Moonstruck eggs", image: "https://image.com", url: "https://www.marmiton.org/recettes/recette_oeufs", yield: 0, ingredientLines: [], ingredients: nil, totalTime: 24.0)
        
        let favoriteRecipe: FavoriteRecipe? = sut.find(recipe)
        XCTAssertEqual(favoriteRecipe?.identifier, recipe.url)
    }
    
    func test_save() {
        //Give a todo item
        let identifier = "https://www.marmiton.org/recettes/recette_poulet"
        let imageURL = "https://image.com"
        let ingredients = "chicken"
        let isFavorite = true
        let totalTime = 60.0
        let name = "recette poulet"
        
        _ = expectationForSaveNotification()
        
        _ = sut.insertRecipe(identifier: identifier, imageURL: imageURL, ingredients: ingredients, isFavorite: isFavorite, totalTime: totalTime, name: name)
        
        //When save
        
        
        //Assert save is called via notification (wait)
        expectation(forNotification: NSNotification.Name(rawValue: Notification.Name.NSManagedObjectContextDidSave.rawValue), object: nil, handler: nil)
        
        sut.save()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    //MARK: mock in-memory persistant store
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "reciplease", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()

    //MARK: Convinient function for notification
    var saveNotificationCompleteHandler: ((Notification)->())?
    
    func expectationForSaveNotification() -> XCTestExpectation {
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }
        return expect
    }
    
    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    
    func contextSaved( notification: Notification ) {
        print("\(notification)")
        saveNotificationCompleteHandler?(notification)
    }
}

//MARK: Create some fakes
extension FavoriteRecipesTests {
    
    func initStubs() {
        
        @discardableResult
        func insertRecipe(identifier: String, imageURL: String, ingredients: String, isFavorite: Bool, totalTime: Double, name: String) -> FavoriteRecipe? {
            
            let obj = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe", into: mockPersistantContainer.viewContext)
            
            obj.setValue(identifier, forKey: "identifier")
            obj.setValue(name, forKey: "name")
            obj.setValue(isFavorite, forKey: "isFavorite")

            return obj as? FavoriteRecipe
        }
        
        insertRecipe(identifier: "https://www.marmiton.org/recettes/recette_oeufs", imageURL: "https://image.com", ingredients: "eggs", isFavorite: true, totalTime: 24.0, name: "Moonstruck eggs")
        insertRecipe(identifier: "https://www.marmiton.org/recettes/recette_agneau", imageURL: "https://image.com", ingredients: "lamb", isFavorite: true, totalTime: 50.0, name: "lamb sausages")
        
        do {
            try mockPersistantContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
        
    }
    
    func flushData() {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        
        try! mockPersistantContainer.viewContext.save()
        
    }
 
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteRecipe")
        let results = try! mockPersistantContainer.viewContext.fetch(request)
        return results.count
    }
        
}
