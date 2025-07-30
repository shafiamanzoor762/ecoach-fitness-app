//
//  WorkoutDetailView.swift
//  ECoach
//
//  Created by apple on 14/04/2025.
//

import SwiftUI

struct WorkoutDetailView: View {

    let workout: Workout
    @State private var isWorkoutActive = false
    @State private var currentStepIndex = 0
    @State private var timeRemaining = 0
    @State private var timer: Timer?
    @State private var showCompletionAlert = false

    private func startWorkout() {
        isWorkoutActive = true
        currentStepIndex = 0
        startStepTimer()
    }

    private func startStepTimer() {
        // Estimate time for this step (in seconds)
        // For simplicity, we'll use 30 seconds per instruction
        // In a real app, you might have specific durations per step
        timeRemaining = 30
        
        timer?.invalidate() // Cancel any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                moveToNextStep()
            }
        }
    }

    private func moveToNextStep() {
        if currentStepIndex < workout.instructions.count - 1 {
            currentStepIndex += 1
            startStepTimer()
        } else {
            completeWorkout()
        }
    }

    private func completeWorkout() {
        timer?.invalidate()
        showCompletionAlert = true
        
        print("Completed workout: \(workout.name)")
    }

    private func cancelWorkout() {
        timer?.invalidate()
        isWorkoutActive = false
         
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if isWorkoutActive {
                    // Workout in progress view
                    VStack(spacing: 20) {
                        Text("Step \(currentStepIndex + 1) of \(workout.instructions.count)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(workout.instructions[currentStepIndex])
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Colr.s_light.opacity(0.1))
                            .cornerRadius(10)
                        
                        Text("\(timeRemaining) seconds remaining")
                            .font(.largeTitle)
                            .monospacedDigit()
                        
                        HStack(spacing: 20) {
                            Button("Previous") {
                                if currentStepIndex > 0 {
                                    currentStepIndex -= 1
                                    startStepTimer()
                                }
                            }
                            .disabled(currentStepIndex == 0)
                            
                            Button("Next") {
                                moveToNextStep()
                            }
                            
                            Button("Cancel", role: .destructive) {
                                cancelWorkout()
                            }
                        }
                    }
                    .padding()
                    .transition(.slide)
                } else {
                    // Regular workout details view
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text(workout.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Colr.p_dark)
                            
                            HStack(spacing: 20) {
                                Label("\(workout.duration) min", systemImage: "clock").foregroundStyle(.green)
                                Label(workout.difficulty, systemImage: "chart.bar.fill").foregroundStyle(Colr.p_dark)
                                Label("\(workout.caloriesBurned) cal", systemImage: "flame").foregroundStyle(.orange)
                            }
                        }
                        
                        Divider()
                        
                        // Equipment
                        if !workout.equipment.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Equipment Needed")
                                    .font(.headline)
                                    .foregroundStyle(Colr.p_light)
                                
                                HStack {
                                    ForEach(workout.equipment, id: \.self) { item in
                                        Text(item)
                                            .padding(5)
                                            .background(Colr.p_light.opacity(0.1))
                                            .cornerRadius(5)
                                    }
                                }
                            }
                        }
                        
                        Divider()
                        
                        // Instructions
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Instructions")
                                .font(.headline).foregroundStyle(Colr.p_light)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                ForEach(Array(workout.instructions.enumerated()), id: \.offset) { index, instruction in
                                    HStack(alignment: .top) {
                                        Text("\(index + 1).")
                                            .fontWeight(.medium)
                                        Text(instruction)
                                    }
                                    .padding(.bottom, 4)
                                }
                            }
                        }
                        
                        Button(action: startWorkout) {
                            Text("Start Workout")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Colr.p_dark)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.top)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(isWorkoutActive ? workout.name : "Workout Details")
        .alert("Workout Complete!", isPresented: $showCompletionAlert) {
            Button("Great job!", role: .cancel) {
                isWorkoutActive = false
            }
        } message: {
            Text("You've completed \(workout.name)!")
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

