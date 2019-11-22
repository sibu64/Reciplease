//
//  RecipesViewController.swift
//  reciplease
//
//  Created by Darrieumerlou on 28/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController, UITableViewDelegate {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    private let apiIngredients = APIIngredients()
    var ingredients: [String]?
    var recipes: [Recipe]?
    weak var tableView: UITableView!
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
    }
    
    private func load() {
        guard let values = ingredients else { return }
        apiIngredients.execute(values) { recipes in
            for recipe in recipes {
                print("\(recipe.label) | \(recipe.image) | \(recipe.totalTime)| \(recipe.ingredientLines)")
            }
        }
    }
    
//    func toggleCells() {
//        DispatchQueue.main.async {
//           self.tableView?.reloadData()
//           }
//    }
    
}
   
    
    
    
    
    
    
 extension RecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeViewCell", for: indexPath) as? RecipeViewCell {
            let recipe = recipes![indexPath.row]
        
            cell.recipeLabel.text = recipe.label
            //print("nom du label:\(recipe.label)")

            return cell
        
        } else {
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes!.count
    }
}

