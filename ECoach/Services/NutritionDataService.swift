//
//  NutritionDataService.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import Foundation
class NutritionDataService {
    static let shared = NutritionDataService()
    
    private init() {}
    
    func getTips(for category: NutritionCategory? = nil) -> [NutritionTip] {
        let allTips = [
            // General Health Tips
            NutritionTip(
                title: "Stay Hydrated",
                description: "Drink at least 8 glasses of water daily to maintain optimal body function.",
                category: .general,
                icon: "drop.fill"
            ),
            NutritionTip(
                title: "Eat Colorful Vegetables",
                description: "Include a variety of colorful vegetables to get a wide range of nutrients.",
                category: .general,
                icon: "leaf.fill"
            ),
            NutritionTip(
                title: "Limit Processed Foods",
                description: "Reduce intake of processed foods high in sugar, salt, and unhealthy fats.",
                category: .general,
                icon: "exclamationmark.triangle.fill"
            ),
            
            // Weight Loss Tips
            NutritionTip(
                title: "Control Portion Sizes",
                description: "Use smaller plates to help control portion sizes and prevent overeating.",
                category: .weightLoss,
                icon: "scalemass.fill"
            ),
            NutritionTip(
                title: "High Protein Breakfast",
                description: "Start your day with a protein-rich breakfast to stay full longer.",
                category: .weightLoss,
                icon: "sunrise.fill"
            ),
            NutritionTip(
                title: "Mindful Eating",
                description: "Eat slowly and without distractions to better recognize fullness cues.",
                category: .weightLoss,
                icon: "brain.head.profile"
            ),
            
            // Muscle Gain Tips
            NutritionTip(
                title: "Protein Intake",
                description: "Consume 1g of protein per pound of body weight for muscle growth.",
                category: .muscleGain,
                icon: "bolt.fill"
            ),
            NutritionTip(
                title: "Post-Workout Nutrition",
                description: "Have protein and carbs within 30 minutes after training for recovery.",
                category: .muscleGain,
                icon: "figure.strengthtraining.traditional"
            ),
            NutritionTip(
                title: "Healthy Fats",
                description: "Include healthy fats like avocados and nuts for hormone production.",
                category: .muscleGain,
                icon: "heart.fill"
            ),
            
            // Immunity Boosters
            NutritionTip(
                title: "Vitamin C Rich Foods",
                description: "Consume citrus fruits, bell peppers, and broccoli to boost immunity.",
                category: .immunity,
                icon: "staroflife.fill"
            ),
            NutritionTip(
                title: "Zinc Sources",
                description: "Include zinc-rich foods like oysters, nuts, and seeds in your diet.",
                category: .immunity,
                icon: "shield.fill"
            ),
            NutritionTip(
                title: "Probiotic Foods",
                description: "Eat yogurt, kefir, and fermented foods for gut health and immunity.",
                category: .immunity,
                icon: "allergens.fill"
            )
        ]
        
        return category == nil ? allTips : allTips.filter { $0.category == category }
    }
    
    func getMealPlan(for goal: NutritionGoal = .maintenance) -> [Meal] {
        let sampleMeals = getMealPlan()
        
        return sampleMeals.filter { goal.dailyCalories.contains($0.calories) }
    }
    
    func getMealPlan() -> [Meal] {
        return [
            // ======================
            // 15 BREAKFAST OPTIONS
            // ======================
            Meal(
                name: "Greek Yogurt Parfait",
                category: .breakfast,
                ingredients: ["Greek yogurt", "Granola", "Mixed berries", "Honey"],
                calories: 320,
                preparationTime: 5,
                instructions: "Layer yogurt, berries, and granola in a glass. Drizzle with honey."
            ),
            Meal(
                name: "Avocado Toast",
                category: .breakfast,
                ingredients: ["Whole grain bread", "Avocado", "Egg", "Red pepper flakes"],
                calories: 350,
                preparationTime: 10,
                instructions: "Toast bread, mash avocado, top with fried egg and spices."
            ),
            Meal(
                name: "Protein Pancakes",
                category: .breakfast,
                ingredients: ["Oat flour", "Protein powder", "Egg whites", "Banana"],
                calories: 400,
                preparationTime: 15,
                instructions: "Mix ingredients and cook on non-stick pan until golden."
            ),
            Meal(
                name: "Vegetable Omelette",
                category: .breakfast,
                ingredients: ["Eggs", "Spinach", "Tomatoes", "Feta cheese"],
                calories: 280,
                preparationTime: 12,
                instructions: "Whisk eggs, cook with vegetables, fold and serve."
            ),
            Meal(
                name: "Chia Pudding",
                category: .breakfast,
                ingredients: ["Chia seeds", "Almond milk", "Vanilla extract", "Fresh mango"],
                calories: 290,
                preparationTime: 2,
                instructions: "Mix ingredients and refrigerate overnight."
            ),
            Meal(
                name: "Breakfast Burrito",
                category: .breakfast,
                ingredients: ["Whole wheat tortilla", "Scrambled eggs", "Black beans", "Salsa"],
                calories: 380,
                preparationTime: 15,
                instructions: "Fill tortilla with ingredients and roll up."
            ),
            Meal(
                name: "Smoothie Bowl",
                category: .breakfast,
                ingredients: ["Frozen berries", "Banana", "Spinach", "Almond butter"],
                calories: 340,
                preparationTime: 8,
                instructions: "Blend ingredients and top with granola."
            ),
            Meal(
                name: "Egg Muffins",
                category: .breakfast,
                ingredients: ["Eggs", "Bell peppers", "Onions", "Turkey bacon"],
                calories: 180,
                preparationTime: 20,
                instructions: "Mix ingredients in muffin tin, bake at 350°F for 15 mins."
            ),
            Meal(
                name: "Overnight Oats",
                category: .breakfast,
                ingredients: ["Rolled oats", "Almond milk", "Chia seeds", "Cinnamon"],
                calories: 300,
                preparationTime: 5,
                instructions: "Combine ingredients and refrigerate overnight."
            ),
            Meal(
                name: "Breakfast Quinoa",
                category: .breakfast,
                ingredients: ["Quinoa", "Almond milk", "Blueberries", "Walnuts"],
                calories: 360,
                preparationTime: 15,
                instructions: "Cook quinoa in milk, top with berries and nuts."
            ),
            Meal(
                name: "Protein Waffles",
                category: .breakfast,
                ingredients: ["Protein powder", "Eggs", "Baking powder", "Coconut flour"],
                calories: 420,
                preparationTime: 15,
                instructions: "Mix ingredients and cook in waffle iron."
            ),
            Meal(
                name: "Smoked Salmon Bagel",
                category: .breakfast,
                ingredients: ["Whole grain bagel", "Smoked salmon", "Cream cheese", "Capers"],
                calories: 390,
                preparationTime: 8,
                instructions: "Toast bagel, spread cream cheese, add salmon and toppings."
            ),
            Meal(
                name: "Breakfast Tacos",
                category: .breakfast,
                ingredients: ["Corn tortillas", "Scrambled eggs", "Avocado", "Pico de gallo"],
                calories: 320,
                preparationTime: 12,
                instructions: "Fill tortillas with scrambled eggs and toppings."
            ),
            Meal(
                name: "Cottage Cheese Bowl",
                category: .breakfast,
                ingredients: ["Cottage cheese", "Peaches", "Almonds", "Cinnamon"],
                calories: 280,
                preparationTime: 3,
                instructions: "Combine ingredients in bowl and serve."
            ),
            Meal(
                name: "French Toast",
                category: .breakfast,
                ingredients: ["Whole grain bread", "Eggs", "Cinnamon", "Maple syrup"],
                calories: 350,
                preparationTime: 15,
                instructions: "Dip bread in egg mixture, cook until golden, add toppings."
            ),

            // =================
            // 15 LUNCH OPTIONS
            // =================
            Meal(
                name: "Quinoa Salad Bowl",
                category: .lunch,
                ingredients: ["Quinoa", "Cherry tomatoes", "Cucumber", "Feta cheese", "Red onion", "Olive oil", "Lemon juice"],
                calories: 420,
                preparationTime: 15,
                instructions: "1. Cook quinoa according to package instructions\n2. Chop vegetables\n3. Combine all ingredients in bowl\n4. Dress with olive oil and lemon juice"
            ),
            Meal(
                name: "Grilled Chicken Wrap",
                category: .lunch,
                ingredients: ["Whole wheat wrap", "Grilled chicken breast", "Romaine lettuce", "Tzatziki sauce", "Tomato slices", "Red onion"],
                calories: 380,
                preparationTime: 10,
                instructions: "1. Spread tzatziki on wrap\n2. Layer chicken and vegetables\n3. Roll tightly and slice in half"
            ),
            Meal(
                name: "Turkey Burger",
                category: .lunch,
                ingredients: ["Ground turkey", "Whole wheat bun", "Avocado", "Baby spinach", "Tomato", "Greek yogurt sauce"],
                calories: 450,
                preparationTime: 20,
                instructions: "1. Form turkey into patties\n2. Grill for 5-6 minutes per side\n3. Toast bun\n4. Assemble with toppings"
            ),
            Meal(
                name: "Mediterranean Lentil Salad",
                category: .lunch,
                ingredients: ["Cooked lentils", "Cucumber", "Kalamata olives", "Feta cheese", "Red pepper", "Olive oil dressing"],
                calories: 390,
                preparationTime: 12,
                instructions: "1. Rinse and drain lentils\n2. Chop vegetables\n3. Combine all ingredients\n4. Add dressing and toss"
            ),
            Meal(
                name: "Asian Chicken Lettuce Wraps",
                category: .lunch,
                ingredients: ["Ground chicken", "Butter lettuce", "Water chestnuts", "Hoisin sauce", "Green onions", "Sesame oil"],
                calories: 360,
                preparationTime: 18,
                instructions: "1. Cook chicken with sauce\n2. Prepare lettuce cups\n3. Fill with chicken mixture\n4. Garnish with green onions"
            ),
            Meal(
                name: "Caprese Stuffed Avocado",
                category: .lunch,
                ingredients: ["Avocado", "Cherry tomatoes", "Fresh mozzarella", "Basil", "Balsamic glaze"],
                calories: 410,
                preparationTime: 8,
                instructions: "1. Halve and pit avocado\n2. Fill with tomato and mozzarella\n3. Drizzle with balsamic\n4. Garnish with basil"
            ),
            Meal(
                name: "Tuna Salad Stuffed Tomato",
                category: .lunch,
                ingredients: ["Large tomato", "Canned tuna", "Greek yogurt", "Celery", "Dijon mustard", "Lemon juice"],
                calories: 340,
                preparationTime: 10,
                instructions: "1. Hollow out tomato\n2. Mix tuna with other ingredients\n3. Stuff mixture into tomato"
            ),
            Meal(
                name: "Vegetable Sushi Rolls",
                category: .lunch,
                ingredients: ["Nori sheets", "Sushi rice", "Cucumber", "Avocado", "Carrot", "Sesame seeds"],
                calories: 370,
                preparationTime: 25,
                instructions: "1. Spread rice on nori\n2. Add vegetable strips\n3. Roll tightly and slice\n4. Sprinkle with sesame seeds"
            ),
            Meal(
                name: "Chickpea Salad Sandwich",
                category: .lunch,
                ingredients: ["Whole grain bread", "Chickpeas", "Celery", "Red onion", "Vegan mayo", "Lemon juice"],
                calories: 400,
                preparationTime: 12,
                instructions: "1. Mash chickpeas\n2. Mix with other ingredients\n3. Spread on bread\n4. Add lettuce if desired"
            ),
            Meal(
                name: "Steak and Blue Cheese Salad",
                category: .lunch,
                ingredients: ["Sirloin steak", "Mixed greens", "Blue cheese", "Walnuts", "Balsamic vinaigrette"],
                calories: 480,
                preparationTime: 15,
                instructions: "1. Grill steak to preference\n2. Slice thinly\n3. Toss greens with dressing\n4. Top with steak and cheese"
            ),
            Meal(
                name: "Mexican Stuffed Peppers",
                category: .lunch,
                ingredients: ["Bell peppers", "Ground turkey", "Brown rice", "Black beans", "Mexican spices", "Cheese"],
                calories: 430,
                preparationTime: 30,
                instructions: "1. Hollow peppers\n2. Cook filling mixture\n3. Stuff peppers\n4. Bake at 375°F for 20 mins"
            ),
            Meal(
                name: "Greek Chicken Pita",
                category: .lunch,
                ingredients: ["Whole wheat pita", "Grilled chicken", "Tzatziki", "Cucumber", "Tomato", "Red onion"],
                calories: 390,
                preparationTime: 10,
                instructions: "1. Warm pita slightly\n2. Layer ingredients\n3. Drizzle with tzatziki\n4. Fold and serve"
            ),
            Meal(
                name: "Shrimp and Avocado Salad",
                category: .lunch,
                ingredients: ["Cooked shrimp", "Avocado", "Mixed greens", "Grapefruit", "Pistachios", "Citrus dressing"],
                calories: 410,
                preparationTime: 12,
                instructions: "1. Combine greens and fruit\n2. Add shrimp and avocado\n3. Top with nuts\n4. Drizzle with dressing"
            ),
            Meal(
                name: "Vegetable Fried Rice",
                category: .lunch,
                ingredients: ["Brown rice", "Egg", "Mixed vegetables", "Soy sauce", "Sesame oil", "Green onions"],
                calories: 380,
                preparationTime: 15,
                instructions: "1. Scramble egg in pan\n2. Add rice and vegetables\n3. Season with soy sauce\n4. Garnish with onions"
            ),
            Meal(
                name: "Buddha Bowl",
                category: .lunch,
                ingredients: ["Quinoa", "Roasted sweet potato", "Kale", "Chickpeas", "Tahini dressing", "Avocado"],
                calories: 440,
                preparationTime: 20,
                instructions: "1. Cook quinoa\n2. Roast sweet potatoes\n3. Massage kale\n4. Assemble bowl with all ingredients"
            ),
            
            

            // ==================
            // 15 DINNER OPTIONS
            // ==================
            Meal(
                name: "Baked Salmon",
                category: .dinner,
                ingredients: ["Salmon fillet", "Lemon", "Fresh dill", "Asparagus", "Olive oil", "Garlic", "Salt & pepper"],
                calories: 500,
                preparationTime: 25,
                instructions: "1. Preheat oven to 400°F\n2. Place salmon on baking sheet\n3. Arrange asparagus around salmon\n4. Drizzle with olive oil, lemon, and seasonings\n5. Bake for 15 minutes until flaky"
            ),
            Meal(
                name: "Vegetable Stir Fry",
                category: .dinner,
                ingredients: ["Firm tofu", "Broccoli florets", "Red bell pepper", "Carrots", "Soy sauce", "Sesame oil", "Ginger", "Garlic"],
                calories: 380,
                preparationTime: 20,
                instructions: "1. Press and cube tofu\n2. Heat oil in wok\n3. Stir-fry vegetables for 5 mins\n4. Add tofu and sauce\n5. Cook 3 more minutes"
            ),
            Meal(
                name: "Chicken Fajitas",
                category: .dinner,
                ingredients: ["Chicken breast", "Bell peppers", "Onion", "Fajita seasoning", "Whole wheat tortillas", "Avocado", "Lime"],
                calories: 450,
                preparationTime: 30,
                instructions: "1. Slice chicken and vegetables\n2. Sauté with seasoning\n3. Warm tortillas\n4. Serve with avocado and lime wedges"
            ),
            Meal(
                name: "Beef and Broccoli",
                category: .dinner,
                ingredients: ["Flank steak", "Broccoli", "Brown rice", "Soy sauce", "Honey", "Garlic", "Sesame seeds"],
                calories: 520,
                preparationTime: 25,
                instructions: "1. Cook rice according to package\n2. Stir-fry beef and broccoli\n3. Add sauce ingredients\n4. Serve over rice with sesame seeds"
            ),
            Meal(
                name: "Stuffed Bell Peppers",
                category: .dinner,
                ingredients: ["Bell peppers", "Ground turkey", "Quinoa", "Tomato sauce", "Italian seasoning", "Mozzarella cheese"],
                calories: 480,
                preparationTime: 40,
                instructions: "1. Preheat oven to 375°F\n2. Cook filling mixture\n3. Stuff peppers and top with cheese\n4. Bake for 25 minutes"
            ),
            Meal(
                name: "Shrimp Scampi",
                category: .dinner,
                ingredients: ["Shrimp", "Whole wheat pasta", "Garlic", "White wine", "Lemon", "Parsley", "Red pepper flakes"],
                calories: 490,
                preparationTime: 20,
                instructions: "1. Cook pasta al dente\n2. Sauté shrimp and garlic\n3. Deglaze with wine\n4. Toss with pasta and lemon"
            ),
            Meal(
                name: "Vegetable Lasagna",
                category: .dinner,
                ingredients: ["Zucchini", "Eggplant", "Ricotta cheese", "Marinara sauce", "Lasagna noodles", "Spinach", "Mozzarella"],
                calories: 420,
                preparationTime: 50,
                instructions: "1. Layer noodles, vegetables, and cheeses\n2. Repeat layers\n3. Bake covered at 375°F for 40 mins\n4. Uncover and bake 10 more mins"
            ),
            Meal(
                name: "Turkey Meatballs with Zoodles",
                category: .dinner,
                ingredients: ["Ground turkey", "Zucchini noodles", "Marinara sauce", "Egg", "Breadcrumbs", "Parmesan cheese"],
                calories: 390,
                preparationTime: 30,
                instructions: "1. Mix and form meatballs\n2. Bake at 400°F for 20 mins\n3. Sauté zoodles\n4. Serve with sauce and meatballs"
            ),
            Meal(
                name: "Mushroom Risotto",
                category: .dinner,
                ingredients: ["Arborio rice", "Mushrooms", "Vegetable broth", "White wine", "Parmesan cheese", "Onion", "Thyme"],
                calories: 460,
                preparationTime: 35,
                instructions: "1. Sauté mushrooms and onions\n2. Toast rice\n3. Gradually add broth while stirring\n4. Finish with cheese"
            ),
            Meal(
                name: "Greek Chicken Bowls",
                category: .dinner,
                ingredients: ["Chicken thighs", "Brown rice", "Cucumber", "Tomato", "Kalamata olives", "Tzatziki", "Lemon"],
                calories: 510,
                preparationTime: 25,
                instructions: "1. Grill chicken with Greek seasoning\n2. Prepare rice\n3. Chop vegetables\n4. Assemble bowls with all ingredients"
            ),
            Meal(
                name: "Black Bean Tacos",
                category: .dinner,
                ingredients: ["Corn tortillas", "Black beans", "Avocado", "Cabbage slaw", "Cilantro", "Lime", "Cotija cheese"],
                calories: 430,
                preparationTime: 15,
                instructions: "1. Warm tortillas\n2. Mash seasoned black beans\n3. Assemble tacos with toppings\n4. Squeeze lime juice"
            ),
            Meal(
                name: "Pork Tenderloin with Roasted Vegetables",
                category: .dinner,
                ingredients: ["Pork tenderloin", "Sweet potatoes", "Brussels sprouts", "Rosemary", "Garlic", "Olive oil"],
                calories: 540,
                preparationTime: 45,
                instructions: "1. Season and sear pork\n2. Roast with vegetables at 425°F\n3. Cook until pork reaches 145°F\n4. Rest before slicing"
            ),
            Meal(
                name: "Eggplant Parmesan",
                category: .dinner,
                ingredients: ["Eggplant", "Marinara sauce", "Mozzarella", "Parmesan", "Egg", "Breadcrumbs", "Basil"],
                calories: 470,
                preparationTime: 50,
                instructions: "1. Bread and bake eggplant slices\n2. Layer with sauce and cheese\n3. Bake at 375°F for 25 mins\n4. Garnish with basil"
            ),
            Meal(
                name: "Coconut Curry",
                category: .dinner,
                ingredients: ["Chicken breast", "Coconut milk", "Curry paste", "Bell peppers", "Basmati rice", "Cilantro", "Lime"],
                calories: 490,
                preparationTime: 30,
                instructions: "1. Cook rice\n2. Sauté chicken and vegetables\n3. Add coconut milk and curry paste\n4. Simmer 15 minutes"
            ),
            Meal(
                name: "Bison Burgers with Sweet Potato Fries",
                category: .dinner,
                ingredients: ["Ground bison", "Whole wheat buns", "Sweet potatoes", "Avocado", "Spinach", "Paprika", "Olive oil"],
                calories: 550,
                preparationTime: 35,
                instructions: "1. Cut sweet potatoes and roast at 425°F\n2. Form and grill burgers\n3. Toast buns\n4. Assemble with toppings"
            ),

            // ==============
            // 5 SNACK OPTIONS
            // ==============
            Meal(
                name: "Protein Energy Balls",
                category: .snack,
                ingredients: ["Oats", "Peanut butter", "Protein powder", "Dark chocolate"],
                calories: 180,
                preparationTime: 15,
                instructions: "Mix ingredients, form balls, refrigerate for 1 hour."
            ),
            Meal(
                name: "Vegetable Sticks with Hummus",
                category: .snack,
                ingredients: ["Carrots", "Celery", "Bell peppers", "Hummus"],
                calories: 150,
                preparationTime: 5,
                instructions: "Cut vegetables and serve with hummus."
            ),
            Meal(
                name: "Hard Boiled Eggs",
                category: .snack,
                ingredients: ["Eggs", "Salt", "Pepper"],
                calories: 140,
                preparationTime: 10,
                instructions: "Boil eggs for 9 minutes, cool, peel and season."
            ),
            Meal(
                name: "Almond Butter Rice Cakes",
                category: .snack,
                ingredients: ["Rice cakes", "Almond butter", "Banana slices"],
                calories: 200,
                preparationTime: 3,
                instructions: "Spread almond butter on rice cakes, top with banana."
            ),
            Meal(
                name: "Greek Yogurt with Nuts",
                category: .snack,
                ingredients: ["Greek yogurt", "Almonds", "Walnuts", "Cinnamon"],
                calories: 220,
                preparationTime: 2,
                instructions: "Combine ingredients and mix well."
            )
        ]
    }
    
    func getDailyPlan(for goal: NutritionGoal) -> DailyMealPlan {
        // Get all available meals
        let allMeals = getMealPlan()
        
        // More flexible filtering that prioritizes but doesn't require all conditions
        let goalAppropriateMeals = allMeals.filter { meal in
            switch goal {
            case .weightLoss:
                // First check if meal meets primary criteria
                if meal.calories <= 500 &&
                   (meal.ingredients.contains("chicken") ||
                    meal.ingredients.contains("fish")) {
                    return true
                }
                // Fallback to any meal under 500 calories
                return meal.calories <= 500
                
            case .maintenance:
                // First check for balanced meals
                if (400...700).contains(meal.calories) &&
                   meal.ingredients.contains(where: { ["quinoa", "brown rice"].contains($0) }) {
                    return true
                }
                // Fallback to any meal in moderate calorie range
                return (400...700).contains(meal.calories)
                
            case .muscleGain:
                // First check for high-protein meals
                if meal.calories >= 600 &&
                   (meal.ingredients.contains("protein") ||
                    meal.ingredients.contains("eggs")) {
                    return true
                }
                // Fallback to any higher calorie meal
                return meal.calories >= 600
            }
        }
        
        // Debug print to check filtered meals
        print("Found \(goalAppropriateMeals.count) meals for \(goal):")
        goalAppropriateMeals.forEach { print("- \($0.name) (\($0.category))") }
        
        // Find meals for each category (only use defaults if absolutely necessary)
        let breakfasts = goalAppropriateMeals.filter { $0.category == .breakfast }
        let lunches = goalAppropriateMeals.filter { $0.category == .lunch }
        let dinners = goalAppropriateMeals.filter { $0.category == .dinner }
        
        // Select random meal from available options to add variety
        let breakfast = breakfasts.randomElement() ?? createDefaultMeal(for: .breakfast, goal: goal)
        let lunch = lunches.randomElement() ?? createDefaultMeal(for: .lunch, goal: goal)
        let dinner = dinners.randomElement() ?? createDefaultMeal(for: .dinner, goal: goal)
        
        // Get all snacks (filtered by goal)
        let snacks = goalAppropriateMeals.filter { $0.category == .snack }
        
        // Calculate total calories
        let total = breakfast.calories + lunch.calories + dinner.calories + snacks.reduce(0) { $0 + $1.calories }
        
        return DailyMealPlan(
            breakfast: breakfast,
            lunch: lunch,
            dinner: dinner,
            snacks: snacks,
            totalCalories: total
        )
    }

    private func createDefaultMeal(for category: MealCategory, goal: NutritionGoal) -> Meal {
        switch (category, goal) {
        case (.breakfast, .weightLoss):
            return Meal(name: "Egg White Veggie Scramble", category: .breakfast,
                       ingredients: ["Egg whites", "Spinach", "Mushrooms"],
                       calories: 250, preparationTime: 10,
                       instructions: "Scramble egg whites with vegetables")
            
        case (.lunch, .weightLoss):
            return Meal(name: "Grilled Chicken Salad", category: .lunch,
                       ingredients: ["Chicken breast", "Mixed greens", "Cucumber"],
                       calories: 350, preparationTime: 15,
                       instructions: "Grill chicken and serve over salad")
            
        case (.dinner, .weightLoss):
            return Meal(name: "Baked Fish with Veggies", category: .dinner,
                       ingredients: ["White fish", "Broccoli", "Lemon"],
                       calories: 400, preparationTime: 20,
                       instructions: "Bake fish and vegetables at 400°F")
            
        case (.breakfast, .maintenance):
            return Meal(name: "Avocado Toast", category: .breakfast,
                       ingredients: ["Whole grain bread", "Avocado", "Egg"],
                       calories: 450, preparationTime: 10,
                       instructions: "Toast bread and top with avocado and egg")
            
        case (.lunch, .maintenance):
            return Meal(name: "Quinoa Bowl", category: .lunch,
                       ingredients: ["Quinoa", "Chickpeas", "Vegetables"],
                       calories: 500, preparationTime: 15,
                       instructions: "Combine cooked quinoa with toppings")
            
        case (.dinner, .maintenance):
            return Meal(name: "Turkey Chili", category: .dinner,
                       ingredients: ["Ground turkey", "Beans", "Tomatoes"],
                       calories: 550, preparationTime: 30,
                       instructions: "Cook turkey and simmer with other ingredients")
            
        case (.breakfast, .muscleGain):
            return Meal(name: "Protein Pancakes", category: .breakfast,
                       ingredients: ["Oats", "Protein powder", "Banana"],
                       calories: 600, preparationTime: 15,
                       instructions: "Mix ingredients and cook on griddle")
            
        case (.lunch, .muscleGain):
            return Meal(name: "Beef and Rice", category: .lunch,
                       ingredients: ["Lean beef", "Brown rice", "Broccoli"],
                       calories: 700, preparationTime: 20,
                       instructions: "Cook beef and serve with rice and veggies")
            
        case (.dinner, .muscleGain):
            return Meal(name: "Salmon with Potatoes", category: .dinner,
                       ingredients: ["Salmon", "Sweet potatoes", "Asparagus"],
                       calories: 750, preparationTime: 25,
                       instructions: "Roast salmon and vegetables together")
            
        default:
            return Meal(name: "Basic Meal", category: category,
                       ingredients: [], calories: 500,
                       preparationTime: 15, instructions: "Prepare basic meal")
        }
    }
    
    func getRecommendedWorkouts(for goal: NutritionGoal) -> [Workout] {
        let workoutCategory: WorkoutCategory
        switch goal {
        case .weightLoss:
            workoutCategory = .weightLoss
        case .muscleGain:
            workoutCategory = .muscleGain
        case .maintenance:
            workoutCategory = .maintenance
        }
        return WorkoutDataService.shared.getWorkouts(for: workoutCategory)
    }

}
