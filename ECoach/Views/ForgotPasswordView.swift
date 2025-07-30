//
//  ForgotPasswordView.swift
//  ECoach
//
//  Created by apple on 14/04/2025.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var message = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 20) {

            Image("reset-password")
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.scaledToFill()
                .frame(maxWidth: 200)
            
            Text("Reset Your Password")
                .foregroundColor(Colr.p_dark)
                .font(.title)
                .bold()
                .padding()
            
            HStack{
                Image(systemName: "person.fill")
                    .foregroundStyle(Colr.s_dark)
                    .padding()
                TextField("Email", text: $email)
            }
            .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.clear)
                .foregroundColor(Colr.p_light)
                .overlay(RoundedRectangle(cornerRadius: 50).stroke(Colr.s_dark, lineWidth: 1))
            
            HStack{
                Image(systemName: "lock.fill")
                    .foregroundStyle(Colr.s_dark)
                    .padding()
                SecureField("New Password", text: $newPassword)
            }
            .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.clear)
                .foregroundColor(Colr.s_light)
                .overlay(RoundedRectangle(cornerRadius: 50).stroke(Colr.s_dark, lineWidth: 1))
            
            HStack{
                Image(systemName: "lock.shield.fill")
                    .foregroundStyle(Colr.s_dark)
                    .padding()
                SecureField("Confirm New Password", text: $confirmPassword)
            }
            .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.clear)
                .foregroundColor(Colr.s_light)
                .overlay(RoundedRectangle(cornerRadius: 50).stroke(Colr.s_dark, lineWidth: 1))

            Button("Reset Password") {
                if newPassword != confirmPassword {
                    message = "Passwords do not match."
                    showAlert = true
                    return
                }
                
                if AuthManager.shared.resetPassword(for: email, newPassword: newPassword) {
                    message = "Password successfully reset."
                    showAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    message = "Email not found."
                    showAlert = true
                }
            }
            .frame(maxWidth: .infinity,maxHeight: 15)
            .padding()
            .background(Colr.p_dark)
            .foregroundColor(Colr.s_light)
            .cornerRadius(25)

            Spacer()
        }
        
        .padding()
        .background(Colr.s_light)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Notification"), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }
}


#Preview {
    ForgotPasswordView()
}
