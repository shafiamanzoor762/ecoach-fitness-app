//
//  Meal.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import Foundation
// Models/Meal.swift
struct Meal: Identifiable, Codable {
    let id = UUID()
    let name: String
    let category: MealCategory
    let ingredients: [String]
    let calories: Int
    let preparationTime: Int // in minutes
    let instructions: String
}

enum MealCategory: String, CaseIterable, Codable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
}

