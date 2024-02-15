//
//  RecipeSelectionLogic.swift
//  MyAdventure
//
//  Created by Elif Dede on 2/14/24.
//

import Foundation
struct RecipeSelectionLogic {
    var layerIndex: Int = 0
    var selectedPath: [String] = []

    var decisions: [DecisionLayer] = [
        DecisionLayer(question: "What's the occasion for your meal today?",
                      options: ["Breakfast", "Dinner"])
    ]

    let recipes: [String: String] = [
        "Breakfast_Eggs_Boiled": "Classic Boiled Eggs with Soldiers",
        "Breakfast_Eggs_Fried": "Spicy Fried Eggs on Toast",
        "Breakfast_Oats_Porridge": "Creamy Maple & Cinnamon Porridge",
        "Breakfast_Oats_OvernightOats": "Berry & Almond Overnight Oats",
        "Dinner_Chicken_Grilled": "Lemon Herb Grilled Chicken Breast",
        "Dinner_Chicken_Baked": "Garlic Parmesan Chicken Thighs",
        "Dinner_Vegetarian_StirFried": "Asian-style Tofu Stir Fry with Veggies",
        "Dinner_Vegetarian_Baked": "Mediterranean Baked Tofu with Tomatoes and Olives"
    ]

    mutating func selectOption(_ choice: String) {
        selectedPath.append(choice)
        updateNextLayer()
    }

    mutating func updateNextLayer() {
        guard layerIndex < decisions.count else { return }

        layerIndex += 1
        let mealType = selectedPath.first
        let mainIngredient = selectedPath.last

        switch layerIndex {
        case 1:
            if mealType == "Breakfast" {
                decisions.append(DecisionLayer(question: "What's your go-to breakfast base?",
                                                options: ["Eggs", "Oats"]))
            } else { // Dinner
                decisions.append(DecisionLayer(question: "What's the star of your dinner plate?",
                                                options: ["Chicken", "Vegetarian"]))
            }
        case 2:
            switch mainIngredient {
            case "Eggs":
                decisions.append(DecisionLayer(question: "How do you like your eggs in the morning?",
                                                options: ["Boiled", "Fried"]))
            case "Oats":
                decisions.append(DecisionLayer(question: "What's your oatmeal style?",
                                                options: ["Porridge", "Overnight_Oats"]))
            case "Chicken":
                decisions.append(DecisionLayer(question: "What's your preferred way to cook chicken?",
                                                options: ["Grilled", "Baked"]))
            case "Vegetarian":
                decisions.append(DecisionLayer(question: "How do you want your veggies?",
                                                options: ["Stir_Fried", "Baked"]))
            default: break
            }
        default: break
        }
    }

    func getNextQuestion() -> String {
        return decisions[layerIndex].question
    }

    func getOptions() -> [String] {
        return decisions[layerIndex].options
    }

    func getFinalRecipe() -> String? {
        guard layerIndex == 3 else { return nil }
        let key = selectedPath.joined(separator: "_")
        return recipes[key]
    }
    func getFinalRecipeImageName() -> String? {
            guard layerIndex == 3 else { return nil }
            let key = selectedPath.joined(separator: "_")
            return key
        }


    mutating func restart() {
        layerIndex = 0
        selectedPath.removeAll()
        decisions = [
            DecisionLayer(question: "What's the occasion for your meal today?",
                          options: ["Breakfast", "Dinner"])
        ]
    }
}
