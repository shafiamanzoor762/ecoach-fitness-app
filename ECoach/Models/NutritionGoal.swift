//
//  NutritionGoal.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import Foundation
enum NutritionGoal: String, CaseIterable {
    case weightLoss = "Weight Loss"
    case maintenance = "Maintenance"
    case muscleGain = "Muscle Gain"
    
    var dailyCalories: Range<Int> {
        switch self {
        case .weightLoss: return 1200..<1800
        case .maintenance: return 1800..<2200
        case .muscleGain: return 2200..<2800
        }
    }
}
