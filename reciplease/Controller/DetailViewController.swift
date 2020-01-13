//
//  ViewController.swift
//  reciplease
//
//  Created by Darrieumerlou on 27/11/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var favIcon: UIBarButtonItem!
    // Properties
    var recipe: Recipe?
    var isFavorite: Bool = false
    var indexPath: IndexPath?
    var currentIngredientViewCell: CurrentIngredientViewCell?
    private var didDelete: ((IndexPath?)->Void)?
    private var coreDataManager: CoreDataManager?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func loadView() {
        super.loadView()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeLabel.text = recipe?.label
        totalTime.text = String(Int(recipe?.totalTime ?? 0.0)) + " min"
        loadPicture()
        
        changeAppearanceForFavorite(isFavorite: isFavorite)
   }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.ingredientsTableView.reloadData()
    }
    
    func changeAppearanceForFavorite(isFavorite: Bool) {
        if isFavorite == true {
            favIcon.tintColor = .systemGreen
        } else {
            favIcon.tintColor = .white
        }
    }
    
    func didDelete(_ completion: ((IndexPath?)->Void)?) {
        self.didDelete = completion
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    @IBAction func btnClicked(_ sender: UIButton) {
        let model = FavoriteRecipe(context: AppDelegate.viewContext)
        guard let urlString = recipe?.url else { return }
        if let url: URL = URL(string: urlString){
            UIApplication.shared.open(url)
        }
        guard let favoriteURLString = model.identifier else { return }
        if let url: URL = URL(string: favoriteURLString){
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favClicked(_ sender: UIBarButtonItem) {
        if isFavorite == false {
            self.isFavorite = true
            changeAppearanceForFavorite(isFavorite: true)
            saveFavoriteRecipe()
        } else {
            deleteFavoriteRecipe()
            changeAppearanceForFavorite(isFavorite: false)
            self.isFavorite = false
            self.navigationController?.popViewController(animated: true)
            self.didDelete?(indexPath)
        }
    }
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    private func saveFavoriteRecipe() {
        let model = FavoriteRecipe(context: AppDelegate.viewContext)
        model.name = recipe?.label
        model.identifier = recipe?.url
        model.isFavorite = true
        model.imageUrlString = recipe?.image
        model.totalTime = recipe?.totalTime ?? 0

        let ingredients = recipe?.ingredients?.map { $0.food }
        model.ingredients = ingredients?.joined(separator: ", ")
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    private func deleteFavoriteRecipe() {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "identifier='\(recipe!.url)'")

        do {
            let favoriteRecipe = try AppDelegate.viewContext.fetch(request).first
            if let value = favoriteRecipe {
                AppDelegate.viewContext.delete(value)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        } catch let error {
            print(error)
        }
    }
    // ***********************************************
    // MARK: - TABLEVIEWS
    // ***********************************************
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: CurrentIngredientViewCell = ingredientsTableView.dequeueReusableCell(withIdentifier: "CurrentIngredientViewCell", for:indexPath) as! CurrentIngredientViewCell
            let ingredient = self.recipe?.ingredients?[indexPath.row].food
            cell.nameLabel?.text = "- " + ingredient!

            return cell
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredients?.count ?? 0
    }
    
    
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    
    private func loadPicture() {
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
