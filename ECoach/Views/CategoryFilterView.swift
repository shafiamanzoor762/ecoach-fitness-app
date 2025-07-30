//
//  CategoryFilterView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct CategoryFilterView: View {
    @Binding var selectedCategory: GoalCategory?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button("All") {
                    selectedCategory = nil
                }
                .buttonStyle(CategoryButtonStyle(isSelected: selectedCategory == nil))
                
                ForEach(GoalCategory.allCases, id: \.self) { category in
                    Button(category.rawValue) {
                        selectedCategory = category
                    }
                    .buttonStyle(CategoryButtonStyle(isSelected: selectedCategory == category))
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryButtonStyle: ButtonStyle {
    let isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Colr.p_dark : Colr.p_light.opacity(0.2))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
    }
}
