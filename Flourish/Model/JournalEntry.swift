//
//  Entry.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import Foundation

struct JournalEntry: Codable, Hashable {
    var topic: String
    var questions: [String]
    var answers: [String]
    var date: Date
    var isCompleted: Bool
    
    init(topic: String, questions: [String], answers: [String], date: Date, isCompleted: Bool) {
        self.topic = topic
        self.questions = questions
        self.answers = answers
        self.date = date
        self.isCompleted = isCompleted
    }
}
