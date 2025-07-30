//
//  SettingsView.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appData: AppData
    @State private var showingLogoutConfirmation = false
    
    var body: some View {
        Form {
            Section(header: Text("Profile")) {
                TextField("Your Name", text: $appData.userName)
            }
            
            Section {
                Button("Refresh Tips") {
                    appData.getRandomTip()
                }
            }
            
            Section {
                Button(role: .destructive) {
                    showingLogoutConfirmation = true
                } label: {
                    HStack {
                        Image(systemName: "arrow.backward.square")
                        Text("Logout")
                    }
                }
            }
            
            Section{
                NavigationLink(destination: ForgotPasswordView()) {
                    Text("Forgot Password?")
                        .foregroundColor(Colr.s_dark)
                }
            }
            
        }.confirmationDialog("Are you sure you want to logout?",
                             isPresented: $showingLogoutConfirmation) {
              Button("Logout", role: .destructive) {
                  logout()
              }
              Button("Cancel", role: .cancel) {}
          }
        .navigationTitle("Settings")
    }
    
    private func logout() {
            AuthManager.shared.logout()
            appData.isLoggedIn = false
        }
}

#Preview {
    SettingsView()
}
