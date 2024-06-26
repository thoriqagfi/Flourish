//
//  JournalingCard.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct ToDoItem: Identifiable {
    var id: Int
    var text: String
    var isCompleted: Bool
}

struct JournalingCard: View {
    var journalType: String
    var date: Date?
    var entry: JournalEntry?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(journalType)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text(entry?.isCompleted == true ? "Completed" : "Incomplete")
                    .font(.caption2)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .cornerRadius(20)
            }
            .padding(.bottom, 20)
            
            if journalType == "Reflection", let entry = entry {
                Text(entry.questions.first ?? "No questions available.")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                Text(entry.answers.first ?? "No reflection available.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
            
            HStack(alignment: .bottom) {
                Text(dateString(for: entry?.date))
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "ellipsis")
                    .frame(width: 43, height: 43)
                    .background(Color.customPrimary30)
                    .cornerRadius(20)
            }
            .padding(.vertical, 8)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
        .padding(.horizontal, 20)
    }
    
    private func dateString(for date: Date?) -> String {
        guard let date = date else { return "" }
        
        let calendar = Calendar.current
        let formatter = DateFormatter()
        
        if calendar.isDateInToday(date) {
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "HH:mm - EEEE, d MMMM yyyy"
            return formatter.string(from: date)
        }
    }
}

#Preview {
    ContentView()
}
