//
//  MealPlannerView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct MealPlannerView: View {
    @State private var selectedGoal: NutritionGoal = .maintenance
    @State private var dailyPlan: DailyMealPlan?
    @State private var showGoalTips = false
    
    var body: some View {
        NavigationStack {
            Form {
                goalSelectionSection
                generateButtonSection
                mealPlanSections
                goalTipsSection
            }
            .navigationTitle("Meal Planner")
        }
    }
    
    private var goalSelectionSection: some View {
        Section("Your Goals") {
            Picker("Nutrition Goal", selection: $selectedGoal) {
                ForEach(NutritionGoal.allCases, id: \.self) { goal in
                    Text(goal.rawValue).tag(goal)
                }
            }
            .pickerStyle(.segmented)
            
            Text("Target: \(selectedGoal.dailyCalories.lowerBound)-\(selectedGoal.dailyCalories.upperBound) calories/day")
                .font(.caption)
            
            Button(action:{
                showGoalTips.toggle()
            }, label:{
                Text("Show Goal Tips")
                    .foregroundStyle(Color.orange)
            })
        }
    }
    
    private var generateButtonSection: some View {
        Section {
            
            Button(action: {
                withAnimation {
                    dailyPlan = NutritionDataService.shared.getDailyPlan(for: selectedGoal)
                }
            }) {
                Text("Generate Plan")
                    .frame(maxWidth: .infinity,maxHeight: 15)
                    .padding()
                    .background(Colr.p_dark)
                    .foregroundColor(Colr.s_light)
                    .cornerRadius(25)
            }
        }
    }
    
    private var mealPlanSections: some View {
        Group {
            if let plan = dailyPlan {
                Section("Breakfast") {
                    MealRow(meal: plan.breakfast)
                }
                
                Section("Lunch") {
                    MealRow(meal: plan.lunch)
                }
                
                Section("Dinner") {
                    MealRow(meal: plan.dinner)
                }
                
                if !plan.snacks.isEmpty {
                    Section("Snacks") {
                        ForEach(plan.snacks) { snack in
                            MealRow(meal: snack)
                        }
                    }
                }
                
                Section("Nutrition Summary") {
                    VStack(alignment: .leading) {
                        Text("Total Calories: \(plan.totalCalories)")
                            .bold()
                        ProgressView(
                            value: Double(plan.totalCalories),
                            total: Double(selectedGoal.dailyCalories.upperBound)
                        ).tint(Colr.p_dark)
                        Text(goalFeedback(for: plan.totalCalories))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
    
    private var goalTipsSection: some View {
        Section {
            if showGoalTips {
                switch selectedGoal {
                case .weightLoss:
                    Text("Focus on lean proteins and vegetables. Reduce simple carbs.")
                case .maintenance:
                    Text("Balance macros evenly. Include variety for micronutrients.")
                case .muscleGain:
                    Text("Increase protein intake. Include healthy fats and complex carbs.")
                }
            }
        }
    }
    
    private func goalFeedback(for calories: Int) -> String {
        if calories < selectedGoal.dailyCalories.lowerBound {
            return "Under target - consider adding a snack"
        } else if calories > selectedGoal.dailyCalories.upperBound {
            return "Over target - consider lighter options"
        } else {
            return "Perfect for your \(selectedGoal.rawValue) goal!"
        }
    }
}

struct MealRow: View {
    let meal: Meal
    
    var body: some View {
        NavigationLink {
            MealDetailView(meal: meal)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(meal.name)
                        .font(.headline)
                        .foregroundColor(Colr.p_dark)
                    
                    Text("\(meal.calories) cal • \(meal.preparationTime) min")
                        .font(.subheadline)
                        .foregroundColor(Colr.p_light)
                }
                
                Spacer()
                
                Text(meal.category.rawValue)
                    .font(.caption)
                    .padding(5)
                    .background(Colr.p_light.opacity(0.2))
                    .cornerRadius(5)
            }
            .padding(.vertical, 8)
            .contentShape(Rectangle()) // Makes entire area tappable
        }
        .buttonStyle(PlainButtonStyle()) // Removes default link styling
    }
}

struct MealDetailView: View {
    let meal: Meal
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(meal.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Colr.p_dark)
                    
                    HStack(spacing: 20) {
                        Label("\(meal.calories) cal", systemImage: "flame").foregroundStyle(.orange)
                        Label("\(meal.preparationTime) min", systemImage: "clock").foregroundStyle(.green)
                    }
                }
                
                Divider()
                
                // Ingredients
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients")
                        .font(.headline)
                        .foregroundStyle(Colr.p_light)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(meal.ingredients, id: \.self) { ingredient in
                            HStack(alignment: .top) {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6))
                                    .padding(.top, 6)
                                Text(ingredient)
                            }
                        }
                    }
                }
                
                Divider()
                
                // Instructions
                VStack(alignment: .leading, spacing: 10) {
                    Text("Instructions")
                        .font(.headline)
                        .foregroundStyle(Colr.p_light)
                    
                    Text(meal.instructions)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Meal Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    MealPlannerView()
}
