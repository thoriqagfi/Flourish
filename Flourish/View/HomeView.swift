//
//  HomeView.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDayIndex: Int? = nil
    @State private var journalEntries: [JournalEntry] = []
    
    var body: some View {
        VStack(spacing: -32, content: {
            TopBar()
                .zIndex(1)
            ScrollView(content: {
                VStack(content: {
                    Image("PlantBackground")
                        .overlay(alignment: .center, content: {
                            VStack(content: {
                                Image("Plant")
                            })
                        })
                    StreakDateCard(selectedDayIndex: $selectedDayIndex)
                        .padding(.top, -32)
                        .padding(.bottom, 32)
                    VStack(spacing: 32, content: {
                        ForEach(journalEntries, id: \.self) { entry in
                            JournalingCard(journalType: "Reflection", date: getSelectedDate(), entry: entry)
                        }
                    })
                    Spacer()
                })
            })
        })
        .background(Color.customPrimary30)
        .onAppear(perform: loadJournalEntries)
    }
    
    func getSelectedDate() -> Date? {
        guard let index = selectedDayIndex else { return nil }
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        let daysToAdd = index - (weekday - 1)
        return calendar.date(byAdding: .day, value: daysToAdd, to: today)
    }
    
    func loadJournalEntries() {
        // Load journal entries using the JournalManager
        journalEntries = JournalManager.shared.loadEntries()
    }
}




#Preview {
    ContentView()
}
