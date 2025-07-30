//
//  Workout.swift
//  ECoach
//
//  Created by apple on 14/04/2025.
//

import Foundation
struct Workout: Identifiable {
    let id = UUID()
    let name: String
    let category: WorkoutCategory
    let duration: Int // in minutes
    let difficulty: String
    let equipment: [String]
    let instructions: [String]
    let caloriesBurned: Int
}
