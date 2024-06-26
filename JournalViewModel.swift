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
    private var entries: [JournalEntry] = []
    
    private init() {
        entries = loadEntries()
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

    // New method to update a question
    func updateQuestion(for topic: String, oldQuestion: String, newQuestion: String) {
        if let entryIndex = entries.firstIndex(where: { $0.topic == topic }) {
            if let questionIndex = entries[entryIndex].questions.firstIndex(of: oldQuestion) {
                entries[entryIndex].questions[questionIndex] = newQuestion
                saveEntries()
            }
        }
    }
    
    func hasEntry(for date: Date) -> Bool {
        return entries.contains { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
}
