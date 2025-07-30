//
//  ECoachApp.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import SwiftUI

@main
struct ECoachApp: App {
    @StateObject private var appData = AppData()
    var body: some Scene {
        WindowGroup {
            if appData.isLoggedIn {
                            ContentView()
                                .environmentObject(appData)
                        } else {
                            AuthView()
                                .environmentObject(appData)
                        }
        }
    }
}
