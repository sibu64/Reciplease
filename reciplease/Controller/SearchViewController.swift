//
//  ViewController.swift
//  reciplease
//
//  Created by Darrieumerlou on 17/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UITableViewDelegate, ActivityIndicatorPresenter {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    // Properties
    let activityIndicator = UIActivityIndicatorView()
    private var ingredients: [String] = []
    private var model: Welcome?
    private var apiIngredients = APIIngredients()
    private var recipes = [Recipe]()
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textField.addBottomBorder()
        tableView.reloadData()
    }
    
//    override func viewDidLoad() {
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//    }
    
    // ***********************************************
    // MARK: - Segue
    // ***********************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "RecipeSegue" {
             let controller = segue.destination as? RecipesViewController
             controller?.set(self.recipes, self.ingredients)
         }
    }
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    private func load() {
        showActivityIndicator()
        guard !ingredients.isEmpty else { return }
        apiIngredients.execute(ingredients) { recipes in
            self.hideActivityIndicator()
            self.recipes = recipes
            self.performSegue(withIdentifier: "RecipeSegue", sender: self)
        }
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
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
        guard !ingredients.isEmpty else { return }
        load()
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
