//
//  AppData.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import Foundation
class AppData: ObservableObject {
    @Published var userName: String = "Ali Raza"
    @Published var goals: [Goal] = []
    @Published var currentTip: Tip = Tip(content: "Stay consistent, not perfect.")
    @Published var isLoggedIn: Bool = AuthManager.shared.isLoggedIn
    
    let tips: [Tip] = [
        Tip(content: "Small steps every day lead to big results."),
        Tip(content: "Consistency is key to success."),
        Tip(content: "Celebrate your small wins."),
        Tip(content: "Progress, not perfection."),
        Tip(content: "You're capable of more than you know."),
        Tip(content: "Every expert was once a beginner."),
        Tip(content: "The secret of getting ahead is getting started.")
    ]
    
    init() {
        loadGoals()
        getRandomTip()
    }
    
    func loadGoals() {
        let dbGoals = DatabaseManager.shared.getAllGoals()
        goals = dbGoals.map { goal in
            // Ensure weeklyProgress has 7 elements
            var updatedGoal = goal
            if updatedGoal.weeklyProgress.count != 7 {
                updatedGoal.weeklyProgress = Array(repeating: false, count: 7)
            }
            return updatedGoal
        }
    }
    
    func getRandomTip() {
        currentTip = tips.randomElement() ?? Tip(content: "Stay consistent, not perfect.")
    }
    
    func addGoal(title: String, target: String, category: GoalCategory, weeklyTarget: Int) {
            if let id = DatabaseManager.shared.createGoal(
                title: title,
                target: target,
                category: category,
                weeklyTarget: weeklyTarget
            ) {
                let newGoal = Goal(
                    id: id,
                    title: title,
                    target: target,
                    isCompleted: false,
                    lastUpdated: Date(),
                    streakCount: 0,
                    category: category,
                    weeklyTarget: weeklyTarget,
                    weeklyProgress: Array(repeating: false, count: 7),
                    notes: ""
                )
                goals.append(newGoal)
            }
        }
        
        func getGoalsByCategory() -> [GoalCategory: [Goal]] {
            Dictionary(grouping: goals, by: { $0.category })
        }
        
        func weeklyCompletionRate() -> Double {
            guard !goals.isEmpty else { return 0 }
            let totalPossible = goals.count * 7
            let completed = goals.flatMap { $0.weeklyProgress }.filter { $0 }.count
            return Double(completed) / Double(totalPossible)
        }
    
    func toggleGoalCompletion(goal: Goal) {
        if let index = goals.firstIndex(where: { $0.id == goal.id }) {
            let newCompletionStatus = !goal.isCompleted
            DatabaseManager.shared.updateGoalCompletion(id: goal.id, isCompleted: newCompletionStatus)
            goals[index].isCompleted = newCompletionStatus
            
            // Update streak count
            if newCompletionStatus {
                goals[index].streakCount += 1
                goals[index].lastUpdated = Date()
            }
        }
    }
    
    func deleteGoal(at indexSet: IndexSet) {
        for index in indexSet {
            let goal = goals[index]
            DatabaseManager.shared.deleteGoal(id: goal.id)
            goals.remove(at: index)
        }
    }
    
    func markGoalComplete(goalId: Int64, dayOfWeek: Int) {
            if let index = goals.firstIndex(where: { $0.id == goalId }) {
                var newProgress = goals[index].weeklyProgress
                guard dayOfWeek >= 0 && dayOfWeek < 7 else { return }
                
                newProgress[dayOfWeek] = true
                goals[index].weeklyProgress = newProgress
                
                // Update streak if completed today
                let today = Calendar.current.component(.weekday, from: Date()) - 1
                if dayOfWeek == today {
                    goals[index].streakCount += 1
                    goals[index].isCompleted = true
                }
                
                DatabaseManager.shared.updateGoalCompletion(
                    id: goalId,
                    isCompleted: true,
                    weeklyProgress: newProgress,
                    streakCount: goals[index].streakCount
                )
            }
        }
        
        func markGoalIncomplete(goalId: Int64) {
            if let index = goals.firstIndex(where: { $0.id == goalId }) {
                goals[index].isCompleted = false
                DatabaseManager.shared.updateGoalCompletion(
                    id: goalId,
                    isCompleted: false,
                    weeklyProgress: goals[index].weeklyProgress,
                    streakCount: goals[index].streakCount
                )
            }
        }

    func resetWeeklyProgress() {
        for index in goals.indices {
            goals[index].weeklyProgress = Array(repeating: false, count: 7)
            DatabaseManager.shared.updateWeeklyProgress(
                id: goals[index].id,
                weeklyProgress: goals[index].weeklyProgress
            )
        }
    }
    
}
