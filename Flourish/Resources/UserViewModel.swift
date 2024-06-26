//
//  UserViewModel.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User
    private let userDefaultsKey = "user"
    
    init() {
        if let userData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let storedUser = try? JSONDecoder().decode(User.self, from: userData) {
            self.user = storedUser
        } else {
            self.user = User(seeds: 0, streaks: 0, teapot: 50)
        }
    }
    
    func addStreaks(amount: Int) {
        user.streaks += amount
        saveChanges()
    }
    
    func addSeeds(amount: Int) {
        user.seeds += amount
        saveChanges()
    }
    
    func addTeapot(amount: Int) {
        user.teapot += amount
        saveChanges()
    }
    
    private func saveChanges() {
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: userDefaultsKey)
        } catch {
            print("Error saving user data: \(error)")
        }
    }
}
