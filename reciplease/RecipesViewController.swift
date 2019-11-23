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
    var ingredients: [String]!
    var recipes: [Recipe]!
    var ingredientList: [Ingredient]!
    @IBOutlet weak var tableView: UITableView!
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
            self.recipes = recipes
            self.toggleCells()
        }
    }
    
    func toggleCells() {
        DispatchQueue.main.async {
           self.tableView?.reloadData()
            // exemple pour didSelect() : var pastaSalad = self.recipes[indexpath.row]
           }
    }
    
}

   
    
    
    
    
 extension RecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeViewCell", for: indexPath) as? RecipeViewCell {
            _ = recipes[indexPath.row]
        
            cell.recipeLabel.text = recipes[indexPath.row].label
            
            if let imageURL = URL(string:recipes[indexPath.row].image) {
                           DispatchQueue.global().async {
                               let data = try? Data(contentsOf: imageURL)
                               if let data = data {
                                   let image = UIImage(data: data)
                                   DispatchQueue.main.async {
                                       cell.recipeImage.image = image
                                   }
                               }
                           }
                       }
       //let stringRepresentation = "-".join(array) // "1-2-3"
            if cell.recipeIngredients.text != nil {
                cell.recipeIngredients.text =  recipes[indexPath.row].ingredients.map { $0.food }.joined(separator: ", ")
            }
            return cell
        
        } else {
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
}

