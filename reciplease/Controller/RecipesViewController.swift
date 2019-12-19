//
//  RecipesViewController.swift
//  reciplease
//
//  Created by Darrieumerlou on 28/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//
import UIKit
import CoreData

class RecipesViewController: UIViewController, UITableViewDelegate {
    
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var tableView: UITableView!
    // Properties
    let viewCell =  RecipeViewCell()
    private var gradientLayer: CAGradientLayer!
    private var detail: DetailViewController!
    private var recipe: Recipe?
    private var ingredients: [String]!
    internal var recipes: [Recipe]!
    var isFromFavorites: Bool = false
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView?.reloadData()
    }
        
    func set(_ recipes: [Recipe], _ ingredients: [String]) {
        self.recipes = recipes
        self.ingredients = ingredients
    }
    
    func clickRecipe(_ sender: UIButton) {
        guard !recipes.isEmpty else { return }
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            guard let recipe = recipe else {
                return
            }
            let controller = segue.destination as? DetailViewController
            controller?.recipe = recipe
            controller?.isFavorite = isFromFavorites
            controller?.indexPath = (sender as! IndexPath)
            controller?.didDelete({ indexPath in
                guard let value = indexPath else { return }
                self.recipes.remove(at: value.row)
                self.tableView.deleteRows(at: [value], with: .fade)
            })
            _ = segue.destination as? DetailViewController
        }
    }
}

extension RecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeViewCell", for: indexPath) as? RecipeViewCell {
            let item = recipes[indexPath.row]
            
            cell.recipeLabel.text = item.label
            
            if let imageURL = URL(string: item.image) {
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
            
            if cell.recipeIngredients.text != nil {
                cell.recipeIngredients.text =  recipes[indexPath.row].ingredients?.map { $0.food }.joined(separator: ", ")
            }
            cell.totalTime.text = String(Int(recipes[indexPath.row].totalTime))+" min"
                        
            if cell.gradientLayer == nil {
                _ =  cell.recipeImage.image
               cell.createGradientLayer()
            }
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe = self.recipes[indexPath.row]
        self.performSegue(withIdentifier: "DetailSegue", sender: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
}
