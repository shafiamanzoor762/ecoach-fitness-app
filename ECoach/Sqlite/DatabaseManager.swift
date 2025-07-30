//
//  DatabaseManager.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import Foundation
import SQLite

class DatabaseManager {
//    static let shared = DatabaseManager()
//    private var db: Connection?
//    
//    private let goals = Table("goals")
//    private let id = Expression<Int64>("id")
//    private let title = Expression<String>("title")
//    private let target = Expression<String>("target")
//    private let isCompleted = Expression<Bool>("isCompleted")
//    private let lastUpdated = Expression<Date>("lastUpdated")
//    private let streakCount = Expression<Int>("streakCount")
//    // Add these columns to your SQLite table setup
//    private let category = Expression<String>("category")
//    private let weeklyTarget = Expression<Int>("weeklyTarget")
//    private let weeklyProgress = Expression<String>("weeklyProgress")
//    private let notes = Expression<String>("notes")
//    
//    private init() {
//        migrateGoals()
//        do {
//            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//            db = try Connection("\(path)/app1db.sqlite3")
//            createTables()
//        } catch {
//            print("Error initializing database: \(error)")
//        }
//    }
//    
//    private func createTables() {
//        do {
//            try db?.run(goals.create(ifNotExists: true) { t in
//                t.column(id, primaryKey: .autoincrement)
//                t.column(title)
//                t.column(target)
//                t.column(isCompleted, defaultValue: false)
//                t.column(lastUpdated, defaultValue: Date())
//                t.column(streakCount, defaultValue: 0)
//                t.column(category)
//                t.column(weeklyTarget, defaultValue: 1)
//                t.column(weeklyProgress, defaultValue: "[]")
//                t.column(notes, defaultValue: "")
//            })
//        } catch {
//            print("Error creating tables: \(error)")
//        }
//    }
    
    static let shared = DatabaseManager()
        private var db: Connection?
        
        // Table and columns declarations...
        private let goals = Table("goals")
        private let id = Expression<Int64>("id")
        private let title = Expression<String>("title")
        private let target = Expression<String>("target")
        private let isCompleted = Expression<Bool>("isCompleted")
        private let lastUpdated = Expression<Date>("lastUpdated")
        private let streakCount = Expression<Int>("streakCount")
        private let category = Expression<String>("category")
        private let weeklyTarget = Expression<Int>("weeklyTarget")
        private let weeklyProgress = Expression<String>("weeklyProgress")
        private let notes = Expression<String>("notes")
        
        private init() {
            initializeDatabase()
        }
        
        private func initializeDatabase() {
            do {
                let path = NSSearchPathForDirectoriesInDomains(
                    .documentDirectory,
                    .userDomainMask,
                    true
                ).first!
                
                db = try Connection("\(path)/db.sqlite3")
                try createTables()
                try migrateIfNeeded()
            } catch {
                print("Database initialization error: \(error)")
                // Handle error appropriately (maybe recreate database)
                recreateDatabase()
            }
        }
        
        private func recreateDatabase() {
            do {
                let path = NSSearchPathForDirectoriesInDomains(
                    .documentDirectory,
                    .userDomainMask,
                    true
                ).first!
                
                // Delete existing database file if needed
                let fileManager = FileManager.default
                let dbPath = "\(path)/db.sqlite3"
                if fileManager.fileExists(atPath: dbPath) {
                    try fileManager.removeItem(atPath: dbPath)
                }
                
                // Reinitialize
                db = try Connection(dbPath)
                try createTables()
            } catch {
                print("Failed to recreate database: \(error)")
                fatalError("Critical database failure")
            }
        }
        
//        private func createTables() {
//            do {
//                try db?.run(goals.create(ifNotExists: true) { t in
//                    t.column(id, primaryKey: .autoincrement)
//                    t.column(title)
//                    t.column(target)
//                    t.column(isCompleted, defaultValue: false)
//                    t.column(lastUpdated, defaultValue: Date())
//                    t.column(streakCount, defaultValue: 0)
//                    t.column(category)
//                    t.column(weeklyTarget, defaultValue: 1)
//                    t.column(weeklyProgress, defaultValue: "[]")
//                    t.column(notes, defaultValue: "")
//                })
//            } catch {
//                print("Error creating tables: \(error)")
//            }
//        }
    
    private func createTables() throws {
            guard let db = db else { throw DatabaseError.connectionFailed }
            
            try db.run(goals.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(title)
                t.column(target)
                t.column(isCompleted, defaultValue: false)
                t.column(lastUpdated, defaultValue: Date())
                t.column(streakCount, defaultValue: 0)
                t.column(category, defaultValue: GoalCategory.other.rawValue)
                t.column(weeklyTarget, defaultValue: 1)
                t.column(weeklyProgress, defaultValue: "[]")
                t.column(notes, defaultValue: "")
            })
        }
    
        
        private func migrateIfNeeded() throws {
            guard let db = db else { throw DatabaseError.connectionFailed }
            
            // Check if new columns exist and add them if needed
            let columns = try db.prepare("PRAGMA table_info(goals)").map { row in
                return row[1] as! String  // Column name is at index 1
            }
            
            if !columns.contains("category") {
                try db.run(goals.addColumn(category, defaultValue: GoalCategory.other.rawValue))
            }
            if !columns.contains("weeklyTarget") {
                try db.run(goals.addColumn(weeklyTarget, defaultValue: 1))
            }
            if !columns.contains("weeklyProgress") {
                try db.run(goals.addColumn(weeklyProgress, defaultValue: "[]"))
            }
            if !columns.contains("notes") {
                try db.run(goals.addColumn(notes, defaultValue: ""))
            }
        }
        
        // MARK: - CRUD Operations

    // Update your CRUD operations to handle new fields
    func createGoal(title: String, target: String, category: GoalCategory = .other, weeklyTarget: Int = 1) -> Int64? {
        do {
            let initialProgress = Array(repeating: false, count: 7)
            let progressData = try JSONEncoder().encode(initialProgress)
            let progressString = String(data: progressData, encoding: .utf8) ?? "[]"
            
            let insert = goals.insert(
                self.title <- title,
                self.target <- target,
                self.category <- category.rawValue,
                self.weeklyTarget <- weeklyTarget,
                self.weeklyProgress <- progressString,
                self.notes <- ""
            )
            let id = try db?.run(insert)
            return id
        } catch {
            print("Error creating goal: \(error)")
            return nil
        }
    }
    
    func getAllGoals() -> [Goal] {
        var goalsList: [Goal] = []
        do {
            for goal in try db!.prepare(goals) {
                // Decode weeklyProgress from JSON string
                let progressData = goal[weeklyProgress].data(using: .utf8) ?? Data()
                let decodedProgress = (try? JSONDecoder().decode([Bool].self, from: progressData)) ?? Array(repeating: false, count: 7)
                
                // Get category from raw value
                let categoryValue = goal[category]
                let goalCategory = GoalCategory(rawValue: categoryValue) ?? .other
                
                goalsList.append(Goal(
                    id: goal[id],
                    title: goal[title],
                    target: goal[target],
                    isCompleted: goal[isCompleted],
                    lastUpdated: goal[lastUpdated],
                    streakCount: goal[streakCount],
                    category: goalCategory,
                    weeklyTarget: goal[weeklyTarget],
                    weeklyProgress: decodedProgress,
                    notes: goal[notes]
                ))
            }
        } catch {
            print("Error fetching goals: \(error)")
        }
        return goalsList
    }

    func updateGoalCompletion(id: Int64, isCompleted: Bool, weeklyProgress: [Bool]? = nil, streakCount: Int? = nil) {
        let goal = goals.filter(self.id == id)
        do {
            var setters: [Setter] = [
                self.isCompleted <- isCompleted,
                self.lastUpdated <- Date()
            ]
            
            if let progress = weeklyProgress {
                let progressData = try JSONEncoder().encode(progress)
                let progressString = String(data: progressData, encoding: .utf8) ?? "[]"
                setters.append(self.weeklyProgress <- progressString)
            }
            
            if let streak = streakCount {
                setters.append(self.streakCount <- streak)
            } else if isCompleted {
                setters.append(self.streakCount <- self.streakCount + 1)
            }
            
            if try db!.run(goal.update(setters)) > 0 {
                print("Goal updated")
            }
        } catch {
            print("Error updating goal: \(error)")
        }
    }

    func updateGoalDetails(id: Int64, title: String, target: String, category: GoalCategory, weeklyTarget: Int, notes: String) {
        let goal = goals.filter(self.id == id)
        do {
            if try db!.run(goal.update(
                self.title <- title,
                self.target <- target,
                self.category <- category.rawValue,
                self.weeklyTarget <- weeklyTarget,
                self.notes <- notes
            )) > 0 {
                print("Goal details updated")
            }
        } catch {
            print("Error updating goal details: \(error)")
        }
    }

    func updateWeeklyProgress(id: Int64, weeklyProgress: [Bool]) {
        let goal = goals.filter(self.id == id)
        do {
            let progressData = try JSONEncoder().encode(weeklyProgress)
            let progressString = String(data: progressData, encoding: .utf8) ?? "[]"
            
            if try db!.run(goal.update(
                self.weeklyProgress <- progressString
            )) > 0 {
                print("Weekly progress updated")
            }
        } catch {
            print("Error updating weekly progress: \(error)")
        }
    }

    func deleteGoal(id: Int64) {
        let goal = goals.filter(self.id == id)
        do {
            try db!.run(goal.delete())
        } catch {
            print("Error deleting goal: \(error)")
        }
    }
    
    private func migrateGoals() {
        do {
            let allGoals = try db!.prepare(goals)
            for goal in allGoals {
                let progressString = goal[weeklyProgress]
                let progressData = progressString.data(using: .utf8) ?? Data()
                
                // Fix invalid progress arrays
                if var progress = try? JSONDecoder().decode([Bool].self, from: progressData) {
                    if progress.count != 7 {
                        progress = Array(repeating: false, count: 7)
                        let newData = try JSONEncoder().encode(progress)
                        let newString = String(data: newData, encoding: .utf8) ?? "[]"
                        
                        try db?.run(goals.filter(id == goal[id])
                            .update(weeklyProgress <- newString))
                    }
                }
            }
        } catch {
            print("Error migrating goals: \(error)")
        }
    }
    
    enum DatabaseError: Error {
            case connectionFailed
            case operationFailed
        }
    
}
