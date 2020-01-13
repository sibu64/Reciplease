//
//  CoreDataManager.swift
//
//


import UIKit
import CoreData

class CoreDataManager {
  
  
//  var recipe: Recipe?
//  static let sharedManager = CoreDataManager()
//  private init() {} // Prevent clients from creating another instance.
//
//  lazy var persistentContainer: NSPersistentContainer = {
//
//    let container = NSPersistentContainer(name: "reciplease")
//
//
//    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//
//      if let error = error as NSError? {
//        fatalError("Unresolved error \(error), \(error.userInfo)")
//      }
//    })
//    return container
//  }()
//
//  func saveContext () {
//    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
//    if context.hasChanges {
//      do {
//        try context.save()
//      } catch {
//        // Replace this implementation with code to handle the error appropriately.
//        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        let nserror = error as NSError
//        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//      }
//    }
//  }
//
//  /*Insert*/
//    func insertRecipe(identifier: String, imageURLString: String, ingredients: String, isFavorite: Bool, name: String, totalTime: Double  )->FavoriteRecipe? {
//
//    /*1.
//     Before you can save or retrieve anything from your Core Data store, you first need to get your hands on an NSManagedObjectContext. You can consider a managed object context as an in-memory “scratchpad” for working with managed objects.
//     Think of saving a new managed object to Core Data as a two-step process: first, you insert a new managed object into a managed object context; then, after you’re happy with your shiny new managed object, you “commit” the changes in your managed object context to save it to disk.
//     Xcode has already generated a managed object context as part of the new project’s template. Remember, this only happens if you check the Use Core Data checkbox at the beginning. This default managed object context lives as a property of the NSPersistentContainer in the application delegate. To access it, you first get a reference to the app delegate.
//     */
//    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
//
//    /*
//     An NSEntityDescription object is associated with a specific class instance
//     Class
//     NSEntityDescription
//     A description of an entity in Core Data.
//
//     Retrieving an Entity with a Given Name here person
//     */
//    let entity = NSEntityDescription.entity(forEntityName: "FavoriteRecipe",
//                                            in: managedContext)!
//
//
//    /*
//     Initializes a managed object and inserts it into the specified managed object context.
//
//     init(entity: NSEntityDescription,
//     insertInto context: NSManagedObjectContext?)
//     */
//    let recipe = NSManagedObject(entity: entity,
//                                 insertInto: managedContext)
//
//    /*
//     With an NSManagedObject in hand, you set the name attribute using key-value coding. You must spell the KVC key (name in this case) exactly as it appears in your Data Model
//     */
//
//    recipe.setValue(identifier, forKeyPath: "identifier")
//    recipe.setValue(imageURLString, forKeyPath: "imageURLString")
//    recipe.setValue(ingredients, forKeyPath: "ingredients")
//    recipe.setValue(isFavorite, forKeyPath: "true")
//    recipe.setValue(name, forKeyPath: "name")
//    recipe.setValue(totalTime, forKeyPath: "0.0")
//
//
//
//    /*
//     You commit your changes to person and save to disk by calling save on the managed object context. Note save can throw an error, which is why you call it using the try keyword within a do-catch block. Finally, insert the new managed object into the people array so it shows up when the table view reloads.
//     */
//    do {
//      try managedContext.save()
//      return recipe as? FavoriteRecipe
//    } catch let error as NSError {
//      print("Could not save. \(error), \(error.userInfo)")
//      return nil
//    }
//  }
//
//
//  /*delete*/
//  func delete(recipe : FavoriteRecipe){
//
//    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
//
//
//      managedContext.delete(recipe)
//
//
//
//    do {
//      try managedContext.save()
//    } catch {
//      // Do something in response to error condition
//    }
//  }
//
//
//// ***********************************************
//// MARK: - Private Methods
//// ***********************************************
//func saveFavoriteRecipe() {
//    let model = FavoriteRecipe(context: AppDelegate.viewContext)
//    model.name = recipe?.label
//    model.identifier = recipe?.url
//    model.isFavorite = true
//    model.imageUrlString = recipe?.image
//    model.totalTime = recipe?.totalTime ?? 0
//
//    let ingredients = recipe?.ingredients?.map { $0.food }
//    model.ingredients = ingredients?.joined(separator: ", ")
//    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
//}
//
//func deleteFavoriteRecipe() {
//    let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
//    request.predicate = NSPredicate(format: "identifier='\(recipe!.url)'")
//
//    do {
//        let favoriteRecipe = try AppDelegate.viewContext.fetch(request).first
//        if let value = favoriteRecipe {
//            AppDelegate.viewContext.delete(value)
//            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
//        }
//    } catch let error {
//        print(error)
//    }
//}
//
//  func fetchAllRecipes() -> [FavoriteRecipe]?{
//
//
//    /*Before you can do anything with Core Data, you need a managed object context. */
//    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
//
//    /*As the name suggests, NSFetchRequest is the class responsible for fetching from Core Data.
//
//     Initializing a fetch request with init(entityName:), fetches all objects of a particular entity. This is what you do here to fetch all Person entities.
//     */
//    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteRecipe")
//
//    /*You hand the fetch request over to the managed object context to do the heavy lifting. fetch(_:) returns an array of managed objects meeting the criteria specified by the fetch request.*/
//    do {
//      let recipes = try managedContext.fetch(fetchRequest)
//      return recipes as? [FavoriteRecipe]
//    } catch let error as NSError {
//      print("Could not fetch. \(error), \(error.userInfo)")
//      return nil
//    }
//  }
}
