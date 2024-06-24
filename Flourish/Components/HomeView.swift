//
//  HomeView.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDayIndex: Int? = nil
    
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
                        JournalingCard(journalType: "Reflection", date: getSelectedDate())
                        JournalingCard(journalType: "To-Do List", date: getSelectedDate())
                    })
                    Spacer()
                })
            })
        })
        .background(Color.customPrimary30)
    }
    
    func getSelectedDate() -> Date? {
        guard let index = selectedDayIndex else { return nil }
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        let daysToAdd = index - (weekday - 1)
        return calendar.date(byAdding: .day, value: daysToAdd, to: today)!
    }
}


#Preview {
    ContentView()
}
