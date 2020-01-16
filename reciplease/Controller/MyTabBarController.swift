//
//  MyTabBarController.swift
//  reciplease
//
//  Created by Darrieumerlou on 27/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var myTabBar: UITabBar!
    // Properties
    private var favoriteRecipes: [FavoriteRecipe] {
        return CoreDataManager().fetchAll
    }
    /*private var recipeController: RecipesViewController? {
        let navigation = children.last as? UINavigationController
        return navigation?.children.first as? RecipesViewController
    }*/
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupTabBarSeparators()
        barItemAppearance()
    }
    // ***********************************************
    // MARK: - Segue
    // ***********************************************
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

extension MyTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let navigation = viewController as? UINavigationController
        if let controller = navigation?.children.first as? RecipesViewController {
            controller.recipes = favoriteRecipes.map { Recipe(with: $0) }
            controller.isFromFavorites = true
                    
            if favoriteRecipes.isEmpty{
                let alert = UIAlertController(title: "You don't have any favorite!", message: "You must click on the star on the recipe's detail's screen to add a recipe to your favorite", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "I have understood", style: .cancel) { alert in
                    self.selectedIndex = 0
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
}
