//
//  StreakDateCard.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct StreakDateCard: View {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        return formatter
    }()
    
    let dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    
    @State private var selectedDayIndex: Int?
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(dateFormatter.string(from: Date()))
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    // Action for "Show more" button
                }) {
                    Text("Show more >")
                }
            }
            
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { index in
                    Button(action: {
                        self.selectedDayIndex = index
                    }) {
                        Text(self.dayOfWeek(for: index))
                            .fontWeight(self.isToday(index) ? .bold : .regular)
                            .foregroundColor(self.isSelected(index) ? .orange : (self.isToday(index) ? .orange : .customSecondary100))
                            .frame(width: 38,height: 40)
                            .padding(.horizontal, 4)
                            .background(self.isSelected(index) ? Color.orange.opacity(0.2) : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .foregroundColor(.customSecondary100)
        .padding()
        .background(Color.customPrimary10)
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
    }
    
    func dayOfWeek(for index: Int) -> String {
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        let daysToAdd = index - (weekday - 1)
        let date = calendar.date(byAdding: .day, value: daysToAdd, to: today)!
        return dayOfWeekFormatter.string(from: date)
    }
    
    func isToday(_ index: Int) -> Bool {
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        return index == (weekday - 1)
    }
    
    func isSelected(_ index: Int) -> Bool {
        return selectedDayIndex == index
    }
}

#Preview {
    ContentView()
}
