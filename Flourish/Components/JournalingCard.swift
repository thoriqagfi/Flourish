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
    
    @State private var toDoList: [ToDoItem] = [
        ToDoItem(id: 0, text: "Attend team meeting at 9:00 AM", isCompleted: false),
        ToDoItem(id: 1, text: "Reflect on the day and journal", isCompleted: false)
    ]
    
    private var completionPercentage: Int {
        let total = toDoList.count
        let completed = toDoList.filter { $0.isCompleted }.count
        return total > 0 ? (completed * 100 / total) : 0
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack(alignment: .center, content: {
                Text(journalType)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text(journalType == "Reflection" || journalType == "Activity" ? "Incomplete" : journalType == "To-Do List" ? "\(completionPercentage)%" : "")
                    .font(.caption2)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .cornerRadius(20)
            })
            .padding(.bottom, 20)
            
            if journalType == "Reflection" {
                // Start Reflection Journaling
                Text("What Happened Today?")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.secondary)
                    .padding(.bottom, 4)
                Text("Today was tough. My car broke down in the middle of heavy traffic. I had to wait for a tow truck in the pouring rain, getting completely...")
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .lineLimit(3)
                // End Reflection Journaling
            } else if journalType == "To-Do List" {
                // Start To-Do List Journaling
                ForEach($toDoList) { $item in
                    HStack(spacing: 4, content: {
                        Image(systemName: item.isCompleted ? "rectangle.inset.filled" : "rectangle")
                            .frame(width: 24, height: 24)
                            .foregroundColor(item.isCompleted ? .customSecondary80 : .secondary)
                        Text(item.text)
                            .font(.subheadline)
                            .strikethrough(item.isCompleted)
                            .foregroundColor(.secondary)
                    })
                    .onTapGesture {
                        item.isCompleted.toggle()
                    }
                }
                // End To-Do List Journaling
            }
            
            HStack(alignment: .bottom, content: {
                Text("20.30")
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
                Image(systemName: journalType == "Reflection" || journalType == "Activity" ? "ellipsis" : journalType == "To-Do List" ? "plus" : "")
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
