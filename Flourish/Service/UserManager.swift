//
//  UserManager.swift
//  Flourish
//
//  Created by Agfi on 26/06/24.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private let userDefaultsUserKey = "user"
    private var currentUser: User
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsUserKey),
           let loadedUser = try? JSONDecoder().decode(User.self, from: data) {
            self.currentUser = loadedUser
        } else {
            self.currentUser = User(seeds: 0, streaks: 0, teapot: 50)
        }
    }
    
    func getCurrentUser() -> User {
        return currentUser
    }
    
    func updateUser(seeds: Int, streaks: Int, teapot: Int) {
        currentUser.seeds = seeds
        currentUser.streaks = streaks
        currentUser.teapot = teapot
        saveCurrentUser()
    }
    
    func saveCurrentUser() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currentUser) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsUserKey)
        }
    }
}
