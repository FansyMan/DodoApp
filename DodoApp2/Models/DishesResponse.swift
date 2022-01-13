//
//  File.swift
//  DodoApp2
//
//  Created by Surgeont on 15.12.2021.
//

import Foundation

struct DishesResponse: Decodable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
