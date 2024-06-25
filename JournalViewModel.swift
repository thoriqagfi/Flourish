//
//  JournalViewModel.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import Foundation

class JournalManager {
    static let shared = JournalManager()
    private let userDefaultsKey = "journalEntries"
    private let userDefaultsUserKey = "currentUser"
    private var currentUser: User
    
    private var entries: [JournalEntry] = []
    
    init() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsUserKey),
           let loadedUser = try? JSONDecoder().decode(User.self, from: data) {
            self.currentUser = loadedUser
        } else {
            self.currentUser = User(seeds: 0, streaks: 0)
        }
        entries = loadEntries()
    }
    
    func getCurrentUser() -> User {
        return currentUser
    }
    
    func updateUser(seeds: Int, streaks: Int) {
        currentUser.seeds = seeds
        currentUser.streaks = streaks
        saveCurrentUser()
    }
    
    private func saveCurrentUser() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currentUser) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsUserKey)
        }
    }
    
    func saveEntry(topic: String, questions: [String], answers: [String]) {
        let newEntry = JournalEntry(topic: topic, questions: questions, answers: answers, date: Date(), isCompleted: false)
        entries.append(newEntry)
        saveEntries()
    }
    
    func loadEntries() -> [JournalEntry] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let loadedEntries = try? JSONDecoder().decode([JournalEntry].self, from: data) {
            return loadedEntries
        }
        return []
    }
    
    func saveEntries() {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
    
    func completeEntry(for topic: String) {
        if let index = entries.firstIndex(where: { $0.topic == topic }) {
            entries[index].isCompleted = true
            saveEntries()
        }
    }
    
    func updateAnswer(for topic: String, question: String, answer: String) {
        if let entryIndex = entries.firstIndex(where: { $0.topic == topic }) {
            if let questionIndex = entries[entryIndex].questions.firstIndex(of: question) {
                entries[entryIndex].answers[questionIndex] = answer
                saveEntries()
            }
        }
    }
    
    func hasEntry(for date: Date) -> Bool {
        return entries.contains { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
}
