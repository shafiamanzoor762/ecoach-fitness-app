//
//  ProgressView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct GoalsProgressView: View {
    @EnvironmentObject var appData: AppData
    @State private var selectedCategory: GoalCategory?
    
    var filteredGoals: [Goal] {
        if let category = selectedCategory {
            return appData.goals.filter { $0.category == category }
        }
        return appData.goals
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Category Filter
                CategoryFilterView(selectedCategory: $selectedCategory)
                    .padding(.top)
                
                // Weekly Completion
                VStack {
                    Text("Weekly Completion")
                        .font(.headline)
                    
                    RingView(
                        progress: appData.weeklyCompletionRate(),
                        thickness: 10
                    )
                    .frame(width: 150, height: 150)
                    
                    Text("\(Int(appData.weeklyCompletionRate() * 100))%")
                        .font(.title)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 5)
                
                // Goals by Category
                ForEach(appData.getGoalsByCategory().sorted(by: { $0.key.rawValue < $1.key.rawValue }), id: \.key) { category, goals in
                    if selectedCategory == nil || selectedCategory == category {
                        VStack(alignment: .leading) {
                            Text(category.rawValue)
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(goals) { goal in
                                GoalProgressCard(goal: goal)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Progress Dashboard")
        .refreshable {
            appData.loadGoals()
        }
    }
}

struct GoalProgressCard: View {
    @EnvironmentObject var appData: AppData
    
    let goal: Goal
        let currentDay: Int
        
        init(goal: Goal) {
            self.goal = goal
            self.currentDay = Calendar.current.component(.weekday, from: Date()) - 1
        }
    
    // Safe access to weekly progress
    private func isDayCompleted(_ day: Int) -> Bool {
        guard day >= 0 && day < goal.weeklyProgress.count else {
            return false
        }
        return goal.weeklyProgress[day]
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(goal.title)
                    .font(.headline)
                
                Spacer()
                
                Text("\(goal.streakCount) day streak")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            ProgressView(value: Double(goal.weeklyProgress.filter { $0 }.count),
                       total: Double(goal.weeklyTarget))
            .tint(Colr.p_dark)
            
            Text("\(goal.weeklyProgress.filter { $0 }.count)/\(goal.weeklyTarget) this week")
                .font(.subheadline)
            
            // Weekly progress indicators - now with safe access

                        HStack {
//                            ForEach(0..<7, id: \.self) { day in
//                                VStack(spacing: 4) {
//                                    Text(Calendar.current.shortWeekdaySymbols[day].prefix(1))
//                                        .font(.caption)
//                                    
//                                    Circle()
//                                        .fill(goal.weeklyProgress[day] ? Color.green : Color.gray.opacity(0.3))
//                                        .frame(width: 16, height: 16)
//                                        .overlay(
//                                            day == currentDay ?
//                                            Circle().stroke(Color.blue, lineWidth: 2) : nil
//                                        )
//                                }
//                                .frame(maxWidth: .infinity)
//                            }
                            
                            // In your GoalProgressCard view, modify the day circles to be tappable
                            ForEach(0..<7, id: \.self) { day in
                                Button(action: {
                                    appData.markGoalComplete(goalId: goal.id, dayOfWeek: day)
                                }) {
                                    VStack(spacing: 4) {
                                        Text(Calendar.current.shortWeekdaySymbols[day].prefix(1))
                                            .font(.caption)
                                        Circle()
                                            .fill(goal.weeklyProgress[day] ? Colr.p_dark : Color.gray.opacity(0.3))
                                            .frame(width: 16, height: 16)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top, 8)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct RingView: View {
    let progress: Double
    let thickness: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: thickness)
                .opacity(0.3)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1)))
                .stroke(style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                .foregroundColor(Colr.p_dark)
                .rotationEffect(Angle(degrees: -90))
        }
    }
}

#Preview {
    ProgressView()
}
