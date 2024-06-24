//
//  ActivityEntry.swift
//  Flourish
//
//  Created by Agfi on 24/06/24.
//

import SwiftUI

struct ActivityEntry: View {
    @State private var currentPage = 0
    @Environment(\.presentationMode) var presentationMode
    
    private let rectCount = 5
    private let rectWidth: CGFloat = 67
    private let rectHeight: CGFloat = 4
    private let rectSpacing: CGFloat = 5
    
    var questions: [String] // Accept the questions array
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: rectSpacing) {
                ForEach(0..<rectCount, id: \.self) { index in
                    Rectangle()
                        .frame(width: rectWidth, height: rectHeight)
                        .foregroundColor(self.getRectangleColor(for: index))
                        .cornerRadius(rectHeight / 2)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            TabView(selection: $currentPage) {
                ForEach(0..<questions.count, id: \.self) { index in
                    PromptedTextbox(
                        question: questions[index],
                        currentPage: $currentPage,
                        totalQuestions: questions.count
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide page status indicators
            .onAppear {
                // Ensure currentPage is set correctly when the view appears
                currentPage = 0 // or set it to the index you want initially selected
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Questionnaire", displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: {
                // Action to go back, e.g., dismiss view
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back")
                    .foregroundColor(.customSecondary100)
            },
            trailing: Button(action: {
                // Submit action
                print("Submit button tapped")
            }) {
                Text("Done")
                    .foregroundColor(currentPage == questions.count - 1 ? .customSecondary100 : .gray)
            }
                .disabled(currentPage != questions.count - 1)
        )
        .background(Color.white)
    }
    
    private func getRectangleColor(for index: Int) -> Color {
        if index <= currentPage {
            return Color.customPrimary100 // Adjust this to your actual color
        } else {
            return Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.18)
        }
    }
}


struct ActivityEntry_Previews: PreviewProvider {
    static var questions = [
        "1. Halo",
        "2. Halo",
        "3. Halo",
        "4. Halo",
        "5. Halo",
    ]
    static var previews: some View {
        ActivityEntry(questions: questions)
    }
}
