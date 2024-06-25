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
    
    func saveEntry(_ entry: JournalEntry) {
        var entries = loadEntries()
        entries.append(entry)
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
    
    func loadEntries() -> [JournalEntry] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let entries = try? JSONDecoder().decode([JournalEntry].self, from: data) {
            return entries
        }
        return []
    }
    
    func updateEntry(for question: String, withAnswer answer: String) {
        var entries = loadEntries()
        if let entryIndex = entries.firstIndex(where: { $0.questions.contains(question) }) {
            if let questionIndex = entries[entryIndex].questions.firstIndex(of: question) {
                entries[entryIndex].answers[questionIndex] = answer
                entries[entryIndex].date = Date()
            }
        } else {
            let newEntry = JournalEntry(questions: [question], answers: [answer], date: Date(), isCompleted: false)
            entries.append(newEntry)
        }
        save(entries: entries)
    }

    func save(entries: [JournalEntry]) {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
    
    func completeEntry(questions: [String], answers: [String]) {
        var entries = loadEntries()
        let newEntry = JournalEntry(questions: questions, answers: answers, date: Date(), isCompleted: true)
        entries.append(newEntry)
        save(entries: entries)
    }
}
