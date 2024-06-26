//
//  ActivityEntry.swift
//  Flourish
//
//  Created by Agfi on 24/06/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ActivityEntry: View {
    @State private var currentPage = 0
    @State private var answers: [String]
    @Environment(\.presentationMode) var presentationMode
    
    private let rectCount = 5
    private let rectWidth: CGFloat = 67
    private let rectHeight: CGFloat = 4
    private let rectSpacing: CGFloat = 5
    
    var topic: String
    @Binding var questions: [String]
    
    @ObservedObject var userViewModel: UserViewModel
    @State private var isLoading = false
    
    init(topic: String, questions: Binding<[String]>, userViewModel: UserViewModel) {
        self.topic = topic
        _questions = questions
        _answers = State(initialValue: Array(repeating: "", count: questions.wrappedValue.count))
        self.userViewModel = userViewModel
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
                        topic: topic,
                        regeneratePrompt: {
                            regenerateQuestions(for: index)
                        }
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear {
                currentPage = 0
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Question \(currentPage + 1)", displayMode: .inline)
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
                Text("Submit")
                    .foregroundColor(currentPage == questions.count - 1 ? .customSecondary100 : .gray)
            }
                .disabled(currentPage != questions.count - 1)
        )
        .background(Color.white)
        .overlay(
            Group {
                if isLoading {
                    Color.black.opacity(0.2)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.black)
                        .frame(width: 300, height: 300)
                }
            }
        )
    }
    
    private func getRectangleColor(for index: Int) -> Color {
        index <= currentPage ? Color.customPrimary100 : Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.18)
    }
    
    private func submitJournal() {
        guard currentPage == questions.count - 1 else {
            print("Not all questions have been answered.")
            return
        }
        
        JournalManager.shared.saveEntry(topic: topic, questions: questions, answers: answers)
        
        let today = Date()
        if !JournalManager.shared.hasEntry(for: today) {
            userViewModel.addTeapot(amount: 5)
            userViewModel.addStreaks(amount: 1)
        }
        
        JournalManager.shared.completeEntry(for: topic)
        
        presentationMode.wrappedValue.dismiss()
    }
    
    private func regenerateQuestions(for index: Int) {
        isLoading = true
        let oldQuestion = questions[index]
        Task {
            let prompt = "I want to write a journal with a topic \(topic). Can you help me make a prompt question to help me writing? Provide me with a question without any following questions or additional description."
            do {
                let response = try await GenerativeModel(name: "gemini-pro", apiKey: "AIzaSyCw_Qr1xj_qgA1yQcxK_9-hZwh7Otn5k8U").generateContent(prompt)
                print("\(response)")
                if let text = response.text {
                    let newQuestion = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !newQuestion.isEmpty {
                        DispatchQueue.main.async {
                            questions[index] = newQuestion
                            JournalManager.shared.updateQuestion(for: topic, oldQuestion: oldQuestion, newQuestion: newQuestion)
                        }
                    }
                }
            } catch {
                print("Error generating question: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
}

struct ActivityEntry_Previews: PreviewProvider {
    static var questions = [
        "1",
        "2",
        "3"
    ]
    static var answer = [
        "1",
        "2",
        "3"
    ]
    static var topic = "Topic"
    static var previews: some View {
        ContentView()
//        ActivityEntry(topic: topic, questions: questions, userViewModel: UserViewModel())
    }
}
