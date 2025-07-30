//
//  AuthView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = true
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 10) {
//                    Text("E-COACH")
//                        .font(.system(size: 32, weight: .bold))
//                        .foregroundColor(Colr.p_dark)
//                    
//                    Text("YOUR KEY TO ACHIEVE YOUR GOAL")
//                        .font(.subheadline)
//                        .foregroundColor(Colr.p_light)
                   
                Image("logo_text")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFill()
                    .frame(width: 360)
                }
                .padding(.top, 40)
                
               
                
                // Form
                VStack(spacing: 20) {
                    
                    Spacer()
                    HStack{
                        Image(systemName: "person")
                            .foregroundStyle(Colr.s_dark)
                            .padding()
                        TextField("Email or Phone", text: $email)
                    }
                    .frame(maxWidth: 300)
                        .frame(height: 50)
                        .background(Color.clear)
                        .foregroundColor(Colr.s_light)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Colr.s_dark, lineWidth: 1))
                   
                    
                    HStack{
                        Image(systemName: "lock.fill")
                            .foregroundStyle(Colr.s_dark)
                            .padding()
                        SecureField("Password", text: $password)
                    }
                    .frame(maxWidth: 300)
                        .frame(height: 50)
                        .background(Color.clear)
                        .foregroundColor(Colr.s_light)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Colr.s_dark, lineWidth: 1))
                    
                    
                }
                .padding(30)
                
                ZStack{
                    
                    Colr.s_light
                        .clipShape(RoundedCorner(radius: 50, corners: [.topLeft, .topRight]))
                    VStack(spacing: 20) {
                        
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot Password?")
                                .foregroundColor(Colr.s_dark)
                        }

                        Button(action: isLoginMode ? handleLogin : handleSignup) {
                            Text(isLoginMode ? "Login" : "Create account")
                                .frame(maxWidth: .infinity,maxHeight: 15)
                                .padding()
                                .background(Colr.p_dark)
                                .foregroundColor(Colr.s_light)
                                .cornerRadius(25)
                        }
                        
                        Text("or").foregroundColor(Colr.s_dark)
                        // Switch between login/signup
                        Button(action: { isLoginMode.toggle() }) {
                            Text(isLoginMode ? "Create an account" : "Already have an account? Login")
                                .frame(maxWidth: .infinity,maxHeight: 15)
                                .padding()
                                .background(Colr.p_light)
                                .foregroundColor(Colr.s_dark)
                                .cornerRadius(25)
                        }
                        
                    }.padding(30)
                }
                
                
                Spacer()
            }
            .background(Colr.p_dark)
            .ignoresSafeArea()
            .alert("Authentication Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .navigationDestination(isPresented: .constant(appData.isLoggedIn)) {
                ContentView()
            }
        }
    }
    
    private func handleLogin() {
        if AuthManager.shared.loginUser(email: email, password: password) {
            appData.isLoggedIn = true
        } else {
            showAlert(message: "Invalid email or password")
        }
    }
    
    private func handleSignup() {
        if AuthManager.shared.registerUser(email: email, password: password) {
            appData.isLoggedIn = true
        } else {
            showAlert(message: "Please enter valid email and password")
        }
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 30
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    AuthView()
}
