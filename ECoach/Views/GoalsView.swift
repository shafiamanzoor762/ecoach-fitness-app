//
//  GoalsView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct GoalsView: View {
    @EnvironmentObject var appData: AppData
    @State private var showingAddGoal = false
    
    var body: some View {
        ZStack {
            // Set the background color for the entire view
            Colr.p_dark.ignoresSafeArea()
            List {
                ForEach(Array(appData.goals.enumerated()), id: \.element.id) { index, goal in
                    GoalRow(goal: goal,index: index)
                        .swipeActions {
                            Button(role: .destructive) {
                                appData.deleteGoal(at: IndexSet([index]))
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .listStyle(.insetGrouped)
            .background(Colr.p_dark)
            .scrollContentBackground(.hidden) // Hide default list background
        }
        .navigationTitle("Your Goals")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingAddGoal = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddGoal) {
            AddGoalView()
        }
            
    }
}

struct GoalRow: View {
    @EnvironmentObject var appData: AppData
    let goal: Goal
    let index: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(goal.title)
                    .font(.headline)
                
                Text(goal.target)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Toggle("", isOn: Binding(
                get: { goal.isCompleted },
                set: { newValue in appData.toggleGoalCompletion(goal: goal)
                    
                    if newValue {
                        let today = Calendar.current.component(.weekday, from: Date()) - 1
                        appData.markGoalComplete(goalId: goal.id, dayOfWeek: today)
                                        } else {
                                            appData.markGoalIncomplete(goalId: goal.id)
                                        }
                }
                
                
            ))
            .labelsHidden()
            .tint(Colr.p_light)
            
            Button(action: {
                appData.deleteGoal(at: IndexSet(integer: index))
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    GoalsView()
}
