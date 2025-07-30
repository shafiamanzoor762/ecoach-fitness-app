//
//  NutritionGuideView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct NutritionGuideView: View {
    @State private var selectedCategory: NutritionCategory?
    @State private var showMealPlanner = false
    @State private var showWorkoutRecommendations = false
    
    // Map nutrition categories to workout categories
    private var recommendedWorkoutCategory: WorkoutCategory? {
        guard let category = selectedCategory else { return nil }
        
        switch category {
        case .weightLoss:
            return .weightLoss
        case .muscleGain:
            return .muscleGain
        case .immunity:
            return .flexibility // Yoga/stretching for immunity
        default:
            return .maintenance
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button("All") {
                            selectedCategory = nil
                        }
                        .buttonStyle(NutritionCategoryButton(isSelected: selectedCategory == nil))
                        
                        ForEach(NutritionCategory.allCases, id: \.self) { category in
                            Button(category.rawValue) {
                                selectedCategory = category
                            }
                            .buttonStyle(NutritionCategoryButton(isSelected: selectedCategory == category))
                        }
                    }
                    .padding()
                }
                
                // Nutrition Tips
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 16)], spacing: 16) {
                    ForEach(NutritionDataService.shared.getTips(for: selectedCategory)) { tip in
                        NutritionTipCard(tip: tip)
                    }
                }
                .padding(.horizontal)
                
                // Workout Recommendations Section
                if let workoutCategory = recommendedWorkoutCategory {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recommended Workouts")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(WorkoutDataService.shared.getWorkouts(for: workoutCategory).prefix(3)) { workout in
                                    WorkoutRecommendationCard(workout: workout)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Button {
                            showWorkoutRecommendations = true
                        } label: {
                            Text("See All \(workoutCategory.rawValue) Workouts")
                                .font(.subheadline)
                                .foregroundColor(Colr.p_dark)
                        }
                        .padding(.horizontal)
                    }
                    .sheet(isPresented: $showWorkoutRecommendations) {
                        WorkoutListView(initialCategory: workoutCategory)
                            .presentationDetents([.medium, .large])
                    }
                }
                
                // Meal Planner Button
                Button {
                    showMealPlanner = true
                } label: {
                    HStack {
                        Image(systemName: "fork.knife")
                        Text("Generate Meal Plan")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Colr.p_dark)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $showMealPlanner) {
                    MealPlannerView()
                        .presentationDetents([.medium, .large])
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Nutrition Guide")
    }
}

struct WorkoutRecommendationCard: View {
    let workout: Workout
    
    var body: some View {
        NavigationLink {
            WorkoutDetailView(workout: workout)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: workoutIcon(for: workout.category))
                    .font(.title)
                    .foregroundColor(Colr.p_dark)
                    .padding(10)
                    .background(Colr.p_light.opacity(0.2))
                    .cornerRadius(10)
                
                Text(workout.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                HStack(spacing: 8) {
                    Label("\(workout.duration) min", systemImage: "clock")
                        .font(.caption2)
                    
                    Text(workout.difficulty)
                        .font(.caption2)
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                }
                .foregroundColor(.secondary)
            }
            .padding()
            .frame(width: 150)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 3)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func workoutIcon(for category: WorkoutCategory) -> String {
        switch category {
        case .weightLoss: return "flame"
        case .muscleGain: return "dumbbell"
        case .maintenance: return "heart"
        case .flexibility: return "figure.mind.and.body"
        }
    }
}

struct NutritionTipCard: View {
    let tip: NutritionTip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: tip.icon)
                    .foregroundColor(Colr.p_dark)
                Text(tip.title)
                    .font(.headline)
            }
            
            Text(tip.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(tip.category.rawValue)
                .font(.caption)
                .padding(5)
                .background(Colr.p_light.opacity(0.2))
                .cornerRadius(5)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    NutritionGuideView()
}
