//
//  AuthManager.swift
//  ECoach
//
//  Created by apple on 13/04/2025.
//

import Foundation
class AuthManager {
    static let shared = AuthManager()
    private let userDefaults = UserDefaults.standard
    
    private let emailKey = "userEmail"
    private let passwordKey = "userPassword"
    private let isLoggedInKey = "isLoggedIn"
    
    var isLoggedIn: Bool {
        userDefaults.bool(forKey: isLoggedInKey)
    }
    
    func registerUser(email: String, password: String) -> Bool {
        guard !email.isEmpty, !password.isEmpty else { return false }
        
        userDefaults.set(email, forKey: emailKey)
        userDefaults.set(password, forKey: passwordKey)
        userDefaults.set(true, forKey: isLoggedInKey)
        return true
    }
    
    func loginUser(email: String, password: String) -> Bool {
        let savedEmail = userDefaults.string(forKey: emailKey) ?? ""
        let savedPassword = userDefaults.string(forKey: passwordKey) ?? ""
        
        if email == savedEmail && password == savedPassword {
            userDefaults.set(true, forKey: isLoggedInKey)
            return true
        }
        return false
    }
    
    func logout() {
        userDefaults.set(false, forKey: isLoggedInKey)
    }
    
    func resetPassword(for email: String, newPassword: String) -> Bool {
        let savedEmail = userDefaults.string(forKey: emailKey) ?? ""
        
        guard email == savedEmail else {
            return false
        }
        
        userDefaults.set(newPassword, forKey: passwordKey)
        return true
    }

}
