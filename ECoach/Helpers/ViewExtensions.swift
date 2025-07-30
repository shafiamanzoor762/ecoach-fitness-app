//
//  ViewExtensions.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct NutritionCategoryButton: ButtonStyle {
    let isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Colr.p_dark : Colr.p_light.opacity(0.2))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
