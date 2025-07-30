//
//  AddGoalView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct AddGoalView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var target = ""
    @State private var selectedCategory: GoalCategory = .health
    @State private var weeklyTarget = 3
    @State private var notes = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Goal Details")) {
                    TextField("Goal title", text: $title).foregroundStyle(Colr.p_dark)
                    TextField("Target description", text: $target).foregroundStyle(Colr.s_dark)
                }
                
                Section(header: Text("Category")) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(GoalCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }.foregroundStyle(Colr.p_dark)
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Weekly Target")) {
                    Stepper("\(weeklyTarget) times per week", value: $weeklyTarget, in: 1...7)
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100).foregroundStyle(Colr.p_light)
                }
                
                Section {
                    
                    Button(action: {
                        if !title.isEmpty {
                            appData.addGoal(
                                title: title,
                                target: target,
                                category: selectedCategory,
                                weeklyTarget: weeklyTarget
                            )
                            dismiss()
                        }
                    }) {
                        Text("Save Goal")
                            .frame(maxWidth: .infinity,maxHeight: 15)
                            .padding()
                            .background(Colr.p_dark)
                            .foregroundColor(Colr.s_light)
                            .cornerRadius(25)
                    }
                    .disabled(title.isEmpty)
                }
            }
            .navigationTitle("New Goal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddGoalView()
}
