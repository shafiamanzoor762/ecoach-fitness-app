//
//  Goal.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import Foundation
// Add this enum for categories
enum GoalCategory: String, CaseIterable, Codable {
    case health = "Health"
    case productivity = "Productivity"
    case learning = "Learning"
    case mindfulness = "Mindfulness"
    case fitness = "Fitness"
    case other = "Other"
}

// Update the Goal model
struct Goal: Identifiable, Codable {
    let id: Int64
    let title: String
    let target: String
    var isCompleted: Bool
    var lastUpdated: Date
    var streakCount: Int
    var category: GoalCategory
    var weeklyTarget: Int
    var weeklyProgress: [Bool]
    var notes: String
    
    init(id: Int64, title: String, target: String, isCompleted: Bool = false,
         lastUpdated: Date = Date(), streakCount: Int = 0, category: GoalCategory = .other,
         weeklyTarget: Int = 1, weeklyProgress: [Bool]? = nil, notes: String = "") {
        self.id = id
        self.title = title
        self.target = target
        self.isCompleted = isCompleted
        self.lastUpdated = lastUpdated
        self.streakCount = streakCount
        self.category = category
        self.weeklyTarget = weeklyTarget
        self.weeklyProgress = weeklyProgress ?? Array(repeating: false, count: 7)
        self.notes = notes
    }
}

