//
//  HomeView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Welcome Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back,")
                        .font(.title2)
                        .foregroundColor(Colr.s_light)
                    
                    Text(appData.userName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Colr.p_light)
                }
                .padding(.horizontal)
                
                // Today's Tip
                VStack(alignment: .leading, spacing: 10) {
                    Text("Today's Tip")
                        .font(.headline)
                        .foregroundColor(Colr.s_dark)
                    
                    Text(appData.currentTip.content)
                        .font(.title3)
                        .italic()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Colr.p_light.opacity(0.4))
                        .cornerRadius(10)
                        .foregroundColor(Colr.p_dark)
                }
                .padding(.horizontal)
                
                // Quick Stats
                VStack(alignment: .leading, spacing: 10) {
                    Text("Your Progress")
                        .font(.headline)
                        .foregroundColor(Colr.s_dark)
                    
                    let completedGoals = appData.goals.filter { $0.isCompleted }.count
                    let totalGoals = appData.goals.count
                    
                    if totalGoals > 0 {
                        ProgressView(value: Double(completedGoals), total: Double(totalGoals))
                            .tint(Colr.p_light)
                        
                        Text("\(completedGoals) of \(totalGoals) goals completed today")
                            .font(.subheadline)
                            .foregroundColor(Colr.s_light)
                    } else {
                        Text("No goals set yet. Add your first goal to get started!")
                            .font(.subheadline)
                            .foregroundColor(Colr.s_light)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Navigation Buttons                
                VStack(spacing: 15) {
                    CustomNavigationLink(
                        destination: GoalsView(),
                        text: "VIEW ALL GOALS",
                        imageName: "goals_list",
                        backgroundColor: .white
                    )
                    
                    CustomNavigationLink(
                        destination: AddGoalView(),
                        text: "ADD NEW GOAL",
                        imageName: "add_goal",
                        backgroundColor: .white
                    )
                    
                    CustomNavigationLink(
                        destination: GoalsProgressView(),
                        text: "VIEW PROGRESS",
                        imageName: "progress",
                        backgroundColor: .white
                    )
                    
                    CustomNavigationLink(
                        destination: NutritionGuideView(),
                        text: "NUTRITION GUIDE",
                        imageName: "food",
                        backgroundColor: .white
                    )
                    
                    CustomNavigationLink(
                        destination: MealPlannerView(),
                        text: "PLAN MEAL",
                        imageName: "diet_plan",
                        backgroundColor: .white
                    )
                    
                    CustomNavigationLink(
                        destination: WorkoutListView(),
                        text: "WORKOUT",
                        imageName: "workout",
                        backgroundColor: .white
                    )
                    
                    CustomNavigationLink(
                        destination: EmptyView(),
                        text: "CHAT WITH AI",
                        imageName: "aichat1",
                        backgroundColor: .white
                    )
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Colr.p_dark)
        .navigationTitle("Home")
        .refreshable {
            appData.loadGoals()
            appData.getRandomTip()
        }
    }
}

#Preview {
    HomeView()
}
