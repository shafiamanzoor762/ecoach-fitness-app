//
//  WorkoutListView.swift
//  ECoach
//
//  Created by apple on 14/04/2025.
//

import SwiftUI

struct WorkoutListView: View {
    let initialCategory: WorkoutCategory
    @State private var selectedCategory: WorkoutCategory
    
    // Initialize with a default category
    init(initialCategory: WorkoutCategory = .weightLoss) {
        self.initialCategory = initialCategory
        self._selectedCategory = State(initialValue: initialCategory)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Category Picker
                Picker("Workout Category", selection: $selectedCategory) {
                    ForEach(WorkoutCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                // Workout List
                List(WorkoutDataService.shared.getWorkouts(for: selectedCategory)) { workout in
                    NavigationLink {
                        WorkoutDetailView(workout: workout)
                    } label: {
                        WorkoutRow(workout: workout)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Workouts")
        }
    }
}

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.name)
                    .font(.headline)
                    .foregroundStyle(Colr.p_dark)
                
                HStack(spacing: 16) {
                    Label("\(workout.duration) min", systemImage: "clock").foregroundStyle(.green)
                    Label(workout.difficulty, systemImage: "chart.bar.fill").foregroundStyle(Colr.s_dark)
                    Label("\(workout.caloriesBurned) cal", systemImage: "flame").foregroundStyle(.orange)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}



#Preview {
    WorkoutListView()
}
