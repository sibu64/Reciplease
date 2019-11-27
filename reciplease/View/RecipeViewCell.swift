//
//  RecipeViewCell.swift
//  reciplease
//
//  Created by Darrieumerlou on 31/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit


class RecipeViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var viewForLayer: UIView!
    var gradientLayer: CAGradientLayer!
   

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        alpha = 0.50
        self.viewForLayer.layer.insertSublayer(gradientLayer, above: self.recipeImage.layer)
    }
}
