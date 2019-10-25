//
//  ViewController.swift
//  reciplease
//
//  Created by Darrieumerlou on 17/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        //tableView.dataSource = self as! UITableViewDataSource
        tableView.reloadData()
    }
   
    @IBAction func addIngredient(_ sender: UIButton) {
        let  name = textField.text
        if !name!.isEmpty {
            let ingredient = Ingredient(name: name ?? "")
        IngredientService.shared.add(ingredient: ingredient)
            
    }
        tableView.reloadData()
    }
    
    @IBAction func clearIngredients(_ sender: UIButton){
        IngredientService.shared.removeIngredients()
        tableView.reloadData()
    }

}
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientViewCell", for: indexPath) as? IngredientViewCell {
            let ingredient = IngredientService.shared.ingredients[indexPath.row].name
        
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
        return IngredientService.shared.ingredients.count
    }

}

extension SearchViewController: UITextFieldDelegate {
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
}
}
