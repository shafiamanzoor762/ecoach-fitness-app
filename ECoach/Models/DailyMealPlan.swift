//
//  DailyMealPlan.swift
//  ECoach
//
//  Created by apple on 14/04/2025.
//

import Foundation
struct DailyMealPlan: Identifiable {
    let id = UUID()
    let breakfast: Meal
    let lunch: Meal
    let dinner: Meal
    let snacks: [Meal]
    let totalCalories: Int
}

func getDailyPlan(for goal: NutritionGoal) -> DailyMealPlan {
    let breakfast = Meal(
        name: "Protein Pancakes",
        category: .breakfast,
        ingredients: ["Oats", "Protein powder", "Egg whites", "Banana"],
        calories: 600,
        preparationTime: 15,
        instructions: "Mix ingredients and cook on skillet"
    ) // ~600 calories
    
    let lunch = Meal(
        name: "Chicken Rice Bowl",
        category: .lunch,
        ingredients: ["Chicken breast", "Brown rice", "Broccoli", "Teriyaki sauce"],
        calories: 800,
        preparationTime: 20,
        instructions: "Cook chicken and rice, steam broccoli, combine"
    )   // ~800 calories
    
    let dinner = Meal(
        name: "Salmon with Quinoa",
        category: .dinner,
        ingredients: ["Salmon fillet", "Quinoa", "Asparagus", "Lemon"],
        calories: 900,
        preparationTime: 25,
        instructions: "Bake salmon, cook quinoa, roast asparagus"
    )   // ~900 calories
    let snacks = [Meal(
        name: "Greek Yogurt Parfait",
        category: .snack,
        ingredients: ["Greek yogurt", "Mixed berries", "Granola"],
        calories: 300,
        preparationTime: 5,
        instructions: "Layer ingredients in a bowl"
    )] // ~300 calories
    
    return DailyMealPlan(
        breakfast: breakfast,
        lunch: lunch,
        dinner: dinner,
        snacks: snacks,
        totalCalories: 2600 // sum of all meals
    )
}
