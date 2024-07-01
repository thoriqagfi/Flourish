//
//  DateRangePickerView.swift
//  Flourish
//
//  Created by Agfi on 27/06/24.
//

import SwiftUI

struct MonthPickerView: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        let months = Array(1...12)
        let years = Array(2000...currentYear)
        
        VStack {
            Picker("Select Year", selection: $selectedDate, content: {
                ForEach(years, id: \.self) { year in
                    Text("\(year)").tag(Calendar.current.date(from: DateComponents(year: year, month: currentMonth))!)
                }
            })
            .pickerStyle(WheelPickerStyle())
            
            Picker("Select Month", selection: $selectedDate, content: {
                ForEach(months, id: \.self) { month in
                    Text(Calendar.current.monthSymbols[month - 1]).tag(Calendar.current.date(from: DateComponents(year: currentYear, month: month))!)
                }
            })
            .pickerStyle(WheelPickerStyle())
        }
    }
}

struct DateRangePickerView: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    var body: some View {
        VStack {
            MonthPickerView(selectedDate: $startDate)
                .frame(height: 200)
            Spacer()
            Button("Done") {
                endDate = Calendar.current.date(byAdding: .day, value: 6, to: startDate)!
            }
            .padding()
        }
    }
}
