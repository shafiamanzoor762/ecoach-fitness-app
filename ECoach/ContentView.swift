//
//  ContentView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appData: AppData
        
        var body: some View {
            NavigationStack {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    GoalsView()
                        .tabItem {
                            Label("Goals", systemImage: "list.bullet")
                        }
                    
                    GoalsProgressView()
                        .tabItem {
                            Label("Progress", systemImage: "chart.bar")
                        }
                    
                    NutritionGuideView()
                            .tabItem {
                                Label("Nutrition", systemImage: "fork.knife")
                            }
                    
                    WorkoutListView()
                            .tabItem {
                                Label("Workouts", systemImage: "figure.run")
                            }
                    
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                    
                    
                }
                .accentColor(Colr.p_light)
                .onAppear {
                                // Customize the tab bar appearance
                                let appearance = UITabBarAppearance()
                                appearance.configureWithOpaqueBackground()
                                appearance.backgroundColor = UIColor(Colr.p_dark) // Background color
                                
                                // Apply to all tab bars in the app
                                UITabBar.appearance().standardAppearance = appearance
                                UITabBar.appearance().scrollEdgeAppearance = appearance
                            }
            }
        }
}

#Preview {
    ContentView()
}
