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
        super.viewWillAppear(animated)
        //self.tabBarController.setupTabBarSeparators()
        //itemSpacing()
        self.textField.addBottomBorder()
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
            let ingredient = "- " + IngredientService.shared.ingredients[indexPath.row].name
        
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

 

class MyTabBarController: UITabBarController {

    
   @IBOutlet weak var myTabBar: UITabBar!
   
override func viewDidLoad() {
  super.viewDidLoad()
  setupTabBarSeparators()
  barItemAppearance()
 }
    
    func setupTabBarSeparators() {
        
    let itemWidth = floor(self.myTabBar.frame.size.width / CGFloat(self.myTabBar.items!.count))

        // this is the separator width.  1.5px matches the line at the top of the tab bar
        let separatorWidth: CGFloat = 1.5

        // iterate through the items in the Tab Bar, except the last one
        for i in 0...((self.myTabBar.items?.count)! - 2) {
            // make a new separator at the end of each tab bar item
            let separator = UIView(frame: CGRect(x: itemWidth * CGFloat(i + 1) - CGFloat(separatorWidth / 2), y: 0, width: CGFloat(separatorWidth), height: self.myTabBar.frame.size.height))

            // set the color to light gray (default line color for tab bar)
            separator.backgroundColor = UIColor.lightGray

            self.myTabBar.addSubview(separator)
            
            let topBorder = CALayer()
            
            let borderHeight: CGFloat = 1.5
            
            topBorder.borderWidth = borderHeight
            topBorder.borderColor = UIColor.lightGray.cgColor
            topBorder.frame = CGRect(x: 0, y: -1, width: self.myTabBar.frame.width, height: borderHeight)
            self.myTabBar.layer.addSublayer(topBorder)
            
        }
    }
    func barItemAppearance(){
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 17)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 17)!], for: .selected)
}
}
