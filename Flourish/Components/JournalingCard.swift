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

    @State private var showMenu = false
    @State private var showEditEntryView = false
    @State private var showDeleteConfirmation = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(entry?.topic ?? "No topic found")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                ZStack {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.customTeks)
                        .onTapGesture {
                            showMenu.toggle()
                        }
                        .contextMenu {
                            if let entry = entry {
                                Button(action: {
                                    showEditEntryView.toggle()
                                }) {
                                    Label("Edit Entry", systemImage: "pencil")
                                }

                                Button(action: {
                                    showDeleteConfirmation.toggle()
                                }) {
                                    Label("Delete Entry", systemImage: "trash")
                                }
                            }
                        }
                        .actionSheet(isPresented: $showDeleteConfirmation) {
                            ActionSheet(
                                title: Text("Delete Entry"),
                                message: Text("Are you sure you want to delete this entry?"),
                                buttons: [
                                    .destructive(Text("Delete")) {
                                        deleteEntry()
                                    },
                                    .cancel()
                                ]
                            )
                        }
                }
                .background(
                    NavigationLink(destination: ActivityEntry(topic: entry?.topic ?? "", questions: .constant(entry?.questions ?? []), userViewModel: UserViewModel()), isActive: $showEditEntryView) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
            .foregroundColor(.customTeks)
            .padding(.bottom, 20)
            
            if journalType == "Reflection", let entry = entry {
                Text(entry.questions.first ?? "No questions available.")
                    .multilineTextAlignment(.leading)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.customTeks2)
                    .opacity(0.6)
                    .padding(.bottom, 4)
                Text(entry.answers.first ?? "No reflection available.")
                    .font(.subheadline)
                    .foregroundColor(.customTeks2)
                    .opacity(0.6)
                    .lineLimit(3)
            }
            
            HStack(alignment: .bottom) {
                Text("\(dateString(for: entry?.date)) - \(journalType)")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text(entry?.isCompleted == true ? "Done" : "Incomplete")
                    .font(.caption2)
                    .foregroundColor(entry?.isCompleted == true ? .customSuccess : .customDanger)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(entry?.isCompleted == true ? Color.customSuccess.opacity(0.1) : Color.customDanger.opacity(0.3))
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func deleteEntry() {
        if let entry = entry {
            JournalManager.shared.deleteEntry(entry)
        }
    }
}


#Preview {
    ContentView()
}
