//
//  Entry.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import Foundation

struct JournalEntry: Codable, Hashable {
    var id: UUID
    var topic: String
    var questions: [String]
    var answers: [String]
    var date: Date
    var isCompleted: Bool
    
    init(id: UUID = UUID(), topic: String, questions: [String], answers: [String], date: Date, isCompleted: Bool) {
        self.id = id
        self.topic = topic
        self.questions = questions
        self.answers = answers
        self.date = date
        self.isCompleted = isCompleted
    }
}
