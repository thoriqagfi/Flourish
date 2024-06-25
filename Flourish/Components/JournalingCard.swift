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
        VStack(alignment: .leading, content: {
            HStack(alignment: .center, content: {
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
            })
            .padding(.bottom, 20)
            
            if journalType == "Reflection" {
                // Start Reflection Journaling
                Text(entry!.questions.first!)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom, 4)
                Text(entry?.answers.first ?? "No reflection available.")
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .lineLimit(3)
                // End Reflection Journaling
            }
            
            HStack(alignment: .bottom, content: {
                Text(dateFormatter.string(from: entry!.date))
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text("-")
                    .font(.caption2)
                    .foregroundColor(Color.gray)
                if let date = date {
                    Text(dateFormatter.string(from: date))
                        .font(.caption2)
                        .foregroundColor(Color.gray)
                }
                Spacer()
                Image(systemName: "ellipsis")
                    .frame(width: 43, height: 43)
                    .background(Color.customPrimary30)
                    .cornerRadius(20)
            })
            .padding(.vertical, 8)
        })
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
        .padding(.horizontal, 20)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        return formatter
    }
}



#Preview {
    ContentView()
}
