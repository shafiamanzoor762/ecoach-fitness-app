//
//  CustomNavigationLink.swift
//  ECoach
//
//  Created by apple on 14/04/2025.
//

import SwiftUI

struct CustomNavigationLink<Destination: View>: View {
    let destination: Destination
    let text: String
    let imageName: String
    let backgroundColor: Color
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                
                // Text in the left
                Text(text)
                    .foregroundColor(Colr.p_light)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                
                // Image on the middle
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .foregroundColor(.white)
                    .padding(.leading, 12)
                
                // Arrow on the right
                Image(systemName: "chevron.right")
                    .foregroundColor(Colr.p_light)
                    .padding(.trailing, 12)
            }
            .frame(height: 200)
            
            .background(backgroundColor)
            .cornerRadius(25)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Colr.p_light, lineWidth: 2))
            
        }
    }
}

#Preview {
//    CustomNavigationLink()
}
