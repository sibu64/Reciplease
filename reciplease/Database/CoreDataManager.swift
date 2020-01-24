//
//  CoreDataManager.swift
//  reciplease
//
//  Created by Darrieumerlou on 15/01/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer!
    var recipe: Recipe?
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    convenience init() {
        //Use the default container for production environment
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    //MARK: save, read, delete
    func insertRecipe( identifier: String, imageURL: String, ingredients: String, isFavorite: Bool, totalTime: Double, name: String) -> FavoriteRecipe? {

        guard let favoriteRecipe = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe", into: backgroundContext) as? FavoriteRecipe else { return nil }
        favoriteRecipe.identifier = identifier
        favoriteRecipe.imageUrlString = imageURL
        favoriteRecipe.ingredients = ingredients
        favoriteRecipe.isFavorite = true
        favoriteRecipe.totalTime = 10.0
        favoriteRecipe.name = name
        
        return favoriteRecipe
    }
    
    var fetchAll: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [FavoriteRecipe]()
    }
    
    func find(_ model: Recipe) ->FavoriteRecipe? {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "identifier='\(model.url)'")
        let result = try? persistentContainer.viewContext.fetch(request).first
        return result
    }
    
    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
    }

    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    
    }
    
}
