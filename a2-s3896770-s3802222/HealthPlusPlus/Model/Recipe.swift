//
//  Recipe.swift
//  HealthPlusPlus
//
//  Created by Muhammad Hazren Rosdi on 31/8/2023.
//

import Foundation

// Represent Recipe
struct Recipe: Decodable, Hashable {
    var label: String
    var image: URL
    var calories: Double
    var totalTime: Double
    var ingredientLines: [String]
}

struct RecipeSearchResult: Decodable {
    var hits: [RecipeSearchHit]
}

struct RecipeSearchHit: Decodable{
    var recipe: Recipe
}
