//
//  ViewController.swift
//  reciplease
//
//  Created by Darrieumerlou on 27/11/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var getDirections: UIButton!
    
    
    
    var recipe: Recipe?
    var selectedIngredients: String?
    var currentIngredientViewCell: CurrentIngredientViewCell?
    
    
    override func loadView() {
        super.loadView()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeLabel.text = recipe?.label
        //print(recipe)
        selectedIngredients = "-" + (recipe?.ingredientLines.joined(separator:"\n") ?? "no ingredient")
        totalTime.text = String(Int(recipe?.totalTime ?? 0.0)) + " min"
        rating.text = String(recipe!.yield)
        loadPicture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.ingredientsTableView.reloadData()
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        guard let urlString = recipe?.url else { return }
        
        if let url: URL = URL(string: urlString){
            UIApplication.shared.open(url)
        }
    }
    
    // ***********************************************
    // MARK: - TABLEVIEWS
    // ***********************************************
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: CurrentIngredientViewCell = ingredientsTableView.dequeueReusableCell(withIdentifier: "CurrentIngredientViewCell", for:indexPath) as! CurrentIngredientViewCell
            let ingredient = self.recipe?.ingredients[indexPath.row].food
            cell.nameLabel?.text = ingredient
            return cell
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredients.count ?? 0
    }
    
    
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    
    private func loadPicture() {
        //let gradientLayer: CAGradientLayer! = CAGradientLayer()
        if let imageURL = URL(string:recipe!.image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                   let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.recipeImage.image = image
                    }
                }
            }
        }
}
}
