//
//  JournalEntryDetailView.swift
//  Flourish
//
//  Created by Agfi on 27/06/24.
//

import SwiftUI

struct JournalEntryDetailView: View {
    var journalType: String
    var entry: JournalEntry
    
    @State private var showEditEntryView = false
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Text("\(formattedDate)")
                    .foregroundColor(.gray)
                    .font(.footnote)
                
                VStack(spacing: 32) {
                    ForEach(0..<entry.questions.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(entry.questions[index])
                                .foregroundColor(.secondary)
                                .font(.body)
                                .fontWeight(.semibold)
                            Divider()
                            Text(entry.answers[index])
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                    }
                }
                .padding(12)
                .background(Color.customPrimary10)
                .cornerRadius(10.0)
                Spacer()
            }
            .padding()
            .navigationTitle(entry.topic)
            .navigationBarItems(trailing: editButton)
        }
        .background(Color.customPrimary30)
        .actionSheet(isPresented: $showDeleteConfirmation) {
            ActionSheet(
                title: Text("Delete Journal Entry"),
                message: Text("Are you sure you want to delete this journal entry?"),
                buttons: [
                    .destructive(Text("Delete")) {
                        deleteEntry()
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $showEditEntryView) {
            ActivityEntry(topic: entry.topic, questions: .constant(entry.questions), userViewModel: UserViewModel(), answers: entry.answers)
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy - HH:mm"
        return formatter.string(from: entry.date)
    }
    
    private var editButton: some View {
        Menu {
            Button(action: {
                showEditEntryView.toggle()
            }) {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(action: {
                showDeleteConfirmation.toggle()
            }) {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.customTeks)
        }
    }
    
    private func deleteEntry() {
        JournalManager.shared.deleteEntry(entry)
        // Optionally handle navigation or other UI updates after deletion
    }
}

#Preview {
    //    JournalEntryDetailView(journalType: "Reflection", entry: Entr)
    ContentView()
}
