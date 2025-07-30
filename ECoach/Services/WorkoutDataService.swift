//
//  WorkoutDataService.swift
//  ECoach
//
//  Created by apple on 14/04/2025.
//

import Foundation
class WorkoutDataService {
    static let shared = WorkoutDataService()
    
    private init() {}
    
    func getWorkouts(for category: WorkoutCategory) -> [Workout] {
        switch category {
        case .weightLoss:
            return [
                Workout(
                    name: "HIIT Blast",
                    category: .weightLoss,
                    duration: 30,
                    difficulty: "Intermediate",
                    equipment: ["None"],
                    instructions: [
                        "Warm up for 5 minutes",
                        "30 sec jumping jacks, 30 sec rest",
                        "30 sec burpees, 30 sec rest",
                        "Repeat for 20 minutes",
                        "Cool down for 5 minutes"
                    ],
                    caloriesBurned: 350
                ),
                Workout(
                    name: "Fat Burn Run",
                    category: .weightLoss,
                    duration: 45,
                    difficulty: "Beginner",
                    equipment: ["Running shoes"],
                    instructions: [
                        "5 min warm-up walk",
                        "Alternate 1 min run with 2 min walk",
                        "Repeat for 30 minutes",
                        "5 min cool-down walk"
                    ],
                    caloriesBurned: 400
                ),
                Workout(
                    name: "Kickboxing Cardio",
                    category: .weightLoss,
                    duration: 40,
                    difficulty: "Advanced",
                    equipment: ["None"],
                    instructions: [
                        "5 min jump rope warm-up",
                        "3 rounds of 3 min kickboxing combinations",
                        "1 min rest between rounds",
                        "Finish with core exercises"
                    ],
                    caloriesBurned: 450
                ),
                Workout(
                    name: "Stair Master Challenge",
                    category: .weightLoss,
                    duration: 25,
                    difficulty: "Intermediate",
                    equipment: ["Stairs or stair machine"],
                    instructions: [
                        "5 min warm-up",
                        "20 sec fast climb, 40 sec moderate pace",
                        "Repeat for 15 minutes",
                        "5 min cool-down"
                    ],
                    caloriesBurned: 300
                ),
                Workout(
                    name: "Cycling Sprint",
                    category: .weightLoss,
                    duration: 35,
                    difficulty: "Intermediate",
                    equipment: ["Bicycle or stationary bike"],
                    instructions: [
                        "5 min warm-up",
                        "30 sec sprint, 90 sec recovery",
                        "Repeat for 25 minutes",
                        "5 min cool-down"
                    ],
                    caloriesBurned: 380
                )
            ]
            
        case .muscleGain:
            return [
                Workout(
                    name: "Upper Body Strength",
                    category: .muscleGain,
                    duration: 45,
                    difficulty: "Intermediate",
                    equipment: ["Dumbbells"],
                    instructions: [
                        "3 sets of 10 bench press",
                        "3 sets of 10 shoulder press",
                        "3 sets of 10 bicep curls",
                        "3 sets of 10 tricep dips",
                        "Finish with core exercises"
                    ],
                    caloriesBurned: 280
                ),
                Workout(
                    name: "Leg Day Power",
                    category: .muscleGain,
                    duration: 50,
                    difficulty: "Advanced",
                    equipment: ["Barbell", "Squat rack"],
                    instructions: [
                        "4 sets of 8 back squats",
                        "3 sets of 10 deadlifts",
                        "3 sets of 12 lunges",
                        "3 sets of 15 calf raises",
                        "Finish with stretching"
                    ],
                    caloriesBurned: 320
                ),
                Workout(
                    name: "Push-Pull Routine",
                    category: .muscleGain,
                    duration: 60,
                    difficulty: "Intermediate",
                    equipment: ["Pull-up bar", "Dumbbells"],
                    instructions: [
                        "4 sets of 8 pull-ups",
                        "4 sets of 8 push-ups",
                        "3 sets of 10 bent-over rows",
                        "3 sets of 10 overhead press",
                        "Finish with core work"
                    ],
                    caloriesBurned: 350
                ),
                Workout(
                    name: "Full Body Hypertrophy",
                    category: .muscleGain,
                    duration: 55,
                    difficulty: "Advanced",
                    equipment: ["Barbell", "Dumbbells"],
                    instructions: [
                        "3 sets of 12 squats",
                        "3 sets of 12 bench press",
                        "3 sets of 12 rows",
                        "3 sets of 12 overhead press",
                        "Finish with accessory work"
                    ],
                    caloriesBurned: 400
                ),
                Workout(
                    name: "Chest & Back Blast",
                    category: .muscleGain,
                    duration: 50,
                    difficulty: "Intermediate",
                    equipment: ["Bench", "Dumbbells"],
                    instructions: [
                        "4 sets of 10 incline press",
                        "4 sets of 10 lat pulldowns",
                        "3 sets of 12 flyes",
                        "3 sets of 12 seated rows",
                        "Finish with stretching"
                    ],
                    caloriesBurned: 300
                )
            ]
            
        case .maintenance:
            return [
                Workout(
                    name: "Full Body Circuit",
                    category: .maintenance,
                    duration: 40,
                    difficulty: "Beginner",
                    equipment: ["Yoga mat"],
                    instructions: [
                        "3 rounds of:",
                        "15 bodyweight squats",
                        "10 push-ups",
                        "20 jumping jacks",
                        "30 sec plank",
                        "1 min rest between rounds"
                    ],
                    caloriesBurned: 300
                ),
                Workout(
                    name: "Swimming Laps",
                    category: .maintenance,
                    duration: 45,
                    difficulty: "Intermediate",
                    equipment: ["Swimsuit", "Goggles"],
                    instructions: [
                        "5 min warm-up",
                        "10 laps freestyle",
                        "5 laps backstroke",
                        "5 laps breaststroke",
                        "5 min cool-down"
                    ],
                    caloriesBurned: 350
                ),
                Workout(
                    name: "Functional Fitness",
                    category: .maintenance,
                    duration: 35,
                    difficulty: "Beginner",
                    equipment: ["Kettlebell"],
                    instructions: [
                        "3 rounds of:",
                        "12 kettlebell swings",
                        "10 step-ups per leg",
                        "15 sit-ups",
                        "30 sec rest between rounds"
                    ],
                    caloriesBurned: 250
                ),
                Workout(
                    name: "Outdoor Hike",
                    category: .maintenance,
                    duration: 60,
                    difficulty: "Beginner",
                    equipment: ["Hiking shoes"],
                    instructions: [
                        "Find a scenic trail",
                        "Maintain moderate pace",
                        "Take water breaks as needed",
                        "Enjoy nature views",
                        "Stretch afterward"
                    ],
                    caloriesBurned: 400
                ),
                Workout(
                    name: "Dance Cardio",
                    category: .maintenance,
                    duration: 50,
                    difficulty: "Beginner",
                    equipment: ["None"],
                    instructions: [
                        "5 min warm-up",
                        "30 min dance routine",
                        "10 min freestyle dancing",
                        "5 min cool-down",
                        "Have fun moving!"
                    ],
                    caloriesBurned: 320
                )
            ]
            
        case .flexibility:
            return [
                Workout(
                    name: "Yoga Flow",
                    category: .flexibility,
                    duration: 30,
                    difficulty: "Beginner",
                    equipment: ["Yoga mat"],
                    instructions: [
                        "Sun salutations x 5",
                        "Warrior sequence",
                        "Balance poses",
                        "Seated stretches",
                        "Final relaxation"
                    ],
                    caloriesBurned: 180
                ),
                Workout(
                    name: "Pilates Core",
                    category: .flexibility,
                    duration: 40,
                    difficulty: "Intermediate",
                    equipment: ["Yoga mat"],
                    instructions: [
                        "Pelvic tilts and bridges",
                        "Single leg stretches",
                        "Rolling like a ball",
                        "Spine stretch forward",
                        "Finish with breathing"
                    ],
                    caloriesBurned: 200
                ),
                Workout(
                    name: "Mobility Routine",
                    category: .flexibility,
                    duration: 25,
                    difficulty: "Beginner",
                    equipment: ["Foam roller"],
                    instructions: [
                        "Neck and shoulder rolls",
                        "Thoracic spine mobility",
                        "Hip flexor stretches",
                        "Hamstring stretches",
                        "Ankle mobility drills"
                    ],
                    caloriesBurned: 150
                ),
                Workout(
                    name: "Tai Chi Basics",
                    category: .flexibility,
                    duration: 45,
                    difficulty: "Beginner",
                    equipment: ["Comfortable clothes"],
                    instructions: [
                        "Begin with breathing exercises",
                        "Practice basic Tai Chi forms",
                        "Focus on slow movements",
                        "Maintain proper posture",
                        "Finish with meditation"
                    ],
                    caloriesBurned: 220
                ),
                Workout(
                    name: "Active Stretching",
                    category: .flexibility,
                    duration: 35,
                    difficulty: "Intermediate",
                    equipment: ["Yoga mat"],
                    instructions: [
                        "Dynamic warm-up",
                        "Active isolated stretching",
                        "PNF stretching techniques",
                        "Yoga-inspired stretches",
                        "Cool down with deep breathing"
                    ],
                    caloriesBurned: 190
                )
            ]
        }
    }
}
