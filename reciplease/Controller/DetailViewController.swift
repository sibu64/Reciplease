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
    private var coreDataManager = CoreDataManager()
    var recipe: Recipe?
    var indexPath: IndexPath?
    var currentIngredientViewCell: CurrentIngredientViewCell?
    private var didDelete: ((IndexPath?)->Void)?
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
        
        changeAppearanceForFavorite(isFavorite: isFavorite())
        
        //Closure to avoid duplicates in the favorite recipes
        coreDataManager.persistentContainer.loadPersistentStores { storeDescription, error in
            self.coreDataManager.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            if let error = error {
                print("Unresolved error \(error)")
            }
        }
   }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.ingredientsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let recipeIsInFavorite = isFavorite()
        changeAppearanceForFavorite(isFavorite: recipeIsInFavorite)
    }
    
    func changeAppearanceForFavorite(isFavorite: Bool) {
        if isFavorite == true {
            favIcon.tintColor = .green
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
        guard let urlString = recipe?.url else { return }
        if let url: URL = URL(string: urlString){
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favClicked(_ sender: UIBarButtonItem) {
        if isFavorite() == false {
            changeAppearanceForFavorite(isFavorite: true)
            saveFavoriteRecipe()
        } else {
            deleteFavoriteRecipe()
            changeAppearanceForFavorite(isFavorite: false)
            self.navigationController?.popViewController(animated: true)
            self.didDelete?(indexPath)
        }
    }
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    private func saveFavoriteRecipe() {
        let model = FavoriteRecipe(context: coreDataManager.persistentContainer.viewContext)
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
        guard let value = recipe else { return }
        if let favoriteRecipe = coreDataManager.find(value) {
            coreDataManager.remove(objectID: favoriteRecipe.objectID)
            coreDataManager.save()
        }
    }
    
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
    
    private func isFavorite() ->Bool {
        guard let value = recipe else { return false }
        if let favoriteRecipe = coreDataManager.find(value) {
            return favoriteRecipe.isFavorite
        }
        return false
    }
    // ***********************************************
    // MARK: - Tableviews
    // ***********************************************
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrentIngredientViewCell = ingredientsTableView.dequeueReusableCell(withIdentifier: CurrentIngredientViewCell.identifier, for:indexPath) as! CurrentIngredientViewCell
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
    
}
