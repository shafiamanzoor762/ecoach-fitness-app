//
//  NutritionTip.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import Foundation
struct NutritionTip: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let category: NutritionCategory
    let icon: String
}

enum NutritionCategory: String, CaseIterable {
    case general = "Healthy Tips"
    case weightLoss = "Weight Loss"
    case muscleGain = "Muscle Gain"
    case immunity = "Immunity Boosters"
}
