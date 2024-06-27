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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Text("\(formattedDate)")
                    .foregroundColor(.gray)
                    .font(.footnote)
                
                VStack(spacing: 32, content: {
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
                })
                .padding(12)
                .background(Color.customPrimary10)
                .cornerRadius(10.0)
                Spacer()
            }
            .padding()
            .navigationTitle(entry.topic)
        }
        .background(Color.customPrimary30)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy - HH:mm"
        return formatter.string(from: entry.date)
    }
}

#Preview {
    //    JournalEntryDetailView(journalType: "Reflection", entry: Entr)
    ContentView()
}
