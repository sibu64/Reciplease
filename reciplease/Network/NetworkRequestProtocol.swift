//
//  NetworkRequestProtocol.swift
//  reciplease
//
//  Created by Darrieumerlou on 26/12/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import Foundation


typealias RecipeResults = ([Recipe])->Void

protocol NetworkRequestProtocol {
    func get(_ ingredients: [String], completion: RecipeResults?)
}
