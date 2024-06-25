//
//  ActivityEntry.swift
//  Flourish
//
//  Created by Agfi on 24/06/24.
//

import SwiftUI

struct ActivityEntry: View {
    @State private var currentPage = 0
    @State private var answers: [String]
    @Environment(\.presentationMode) var presentationMode
    
    private let rectCount = 5
    private let rectWidth: CGFloat = 67
    private let rectHeight: CGFloat = 4
    private let rectSpacing: CGFloat = 5
    
    var topic: String
    var questions: [String]
    
    init(topic: String, questions: [String]) {
        self.topic = topic
        self.questions = questions
        _answers = State(initialValue: Array(repeating: "", count: questions.count))
    }
    
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
                        answer: self.$answers[index], 
                        topic: topic
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide page status indicators
            .onAppear {
                currentPage = 0 // Reset currentPage when view appears
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Questionnaire", displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back")
                    .foregroundColor(.customSecondary100)
            },
            trailing: Button(action: {
                self.submitJournal()
            }) {
                Text("Submit Journal")
                    .foregroundColor(currentPage == questions.count - 1 ? .customSecondary100 : .gray)
            }
            .disabled(currentPage != questions.count - 1)
        )
        .background(Color.white)
    }
    
    private func getRectangleColor(for index: Int) -> Color {
        index <= currentPage ? Color.customPrimary100 : Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.18)
    }
    
    private func submitJournal() {
        guard currentPage == questions.count - 1 else {
            print("Not all questions have been answered.")
            return
        }
        
        // Save answers to JournalManager
        JournalManager.shared.saveEntry(topic: topic, questions: questions, answers: answers)
        
        // Complete the journal entry
        JournalManager.shared.completeEntry(for: topic)
        
        // Perform any additional actions, like dismissing the view
        presentationMode.wrappedValue.dismiss()
    }
}


struct ActivityEntry_Previews: PreviewProvider {
    static var questions = [
        "1. Example Question 1",
        "2. Example Question 2",
        "3. Example Question 3",
        "4. Example Question 4",
        "5. Example Question 5",
    ]
    static var previews: some View {
//        ActivityEntry(questions: questions)
        ContentView()
    }
}
