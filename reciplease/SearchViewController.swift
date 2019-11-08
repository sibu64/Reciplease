//
//  ViewController.swift
//  reciplease
//
//  Created by Darrieumerlou on 17/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var ingredients: [String] = []
    var recipes: [Recipe]? = []
    var apiIngredients = APIIngredients()
    var model: Welcome?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.tabBarController.setupTabBarSeparators()
        //itemSpacing()
        self.textField.addBottomBorder()
        tableView.reloadData()
        
    }
   
    @IBAction func addIngredient(_ sender: UIButton) {
        let name = textField.text
        if !name!.isEmpty {
            let ingredient = (name ?? "")
            ingredients.append(ingredient)
            textField.text = ""
        }
        tableView.reloadData()
    }
    
    @IBAction func clearIngredients(_ sender: UIButton){
        ingredients.removeAll()
        tableView.reloadData()
    }
    
    @IBAction func searchRecipes(_ sender: UIButton) {
       //appel réseau
        guard !ingredients.isEmpty else {
            return
        }
        apiIngredients.execute(ingredients) { recipes in
            print(recipes)
        }
//        apiIngredients.execute(ingredients){ (json,error) in
//            //print(json)
//        if let error = error{
//            self.textField.text = error.localizedDescription
//        }else if let json = json {
//            self.textField.text = json.description
//            //self.model = try? JSONDecoder().decode(Base.self, from: recipes!)
//            }
        
            self.performSegue(withIdentifier: "RecipeSegue", sender: self)
        
        //self.model = try JSONDecoder().decode([Recipe].self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            if let searchRecipes = recipes {
                if let nextScreen = segue.destination as? RecipesViewController {
                    nextScreen.recipe = searchRecipes
                    //let vc: RecipesViewController = RecipesViewController()
                    //self.present(vc, animated: true, completion: nil)
                }
            }

       }
   }
}
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientViewCell", for: indexPath) as? IngredientViewCell {
            let ingredient = "- " + ingredients[indexPath.row]
        
            cell.ingredientNameLabel.text = ingredient

            return cell
        
        } else {
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    func hideKeyboard() {
        textField?.resignFirstResponder()
    }
    @IBAction func actionHideKeyboard(sender: UITapGestureRecognizer) {
        self.hideKeyboard()
    }
}

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

extension SearchViewController: UITextFieldDelegate {
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
   }
}
