//
//  ActivityEntry.swift
//  Flourish
//
//  Created by Riyadh on 24/06/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ActivityEntry: View {
    @State private var currentPage = 0
    @State private var answers: [String]
    @State private var totalWordsWritten = 0
    @State private var writingStartTime = Date()
    @State private var showWritingRecap = false
    @State private var totalWritingTime: String = "00:00"
    
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
        ScrollView {
            VStack {
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
                .frame(width: UIScreen.main.bounds.width)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onAppear {
                    currentPage = 0
                    writingStartTime = Date()
                }
                
//                Spacer()
                
                CustomPageControl(numberOfPages: questions.count, currentPage: $currentPage)
                    .frame(width: 108, height: 25) // Adjust width and height as needed
                    .background(Color.customPrimary10) // Example color, replace with your custom color
                    .cornerRadius(20)
                    .padding(.top, -90)
//                    .padding(.bottom, 75) // Add spacing from the bottom
                
                
                NavigationLink(destination: WritingRecap(answers: answers, totalWords: totalWordsWritten, totalMinutes: totalWritingTime, streak: userViewModel.user.streaks), isActive: $showWritingRecap) {
                    EmptyView()
                }
                .hidden()
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
            .frame(width: 393, height: 900)
            .background(Color.customPrimary30)
            .overlay(
                Group {
                    if isLoading {
                        Color.black.opacity(0.2)
                            .edgesIgnoringSafeArea(.all)
                            .blur(radius: 10.0)
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.black)
                            .frame(width: 300, height: 300)
                    }
                }
            )
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            setupNavigationBarAppearance()
        }
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "Primary10")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "teks") ?? .black] // Customize text color if needed
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
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
        
        totalWordsWritten = answers.reduce(0) { total, answer in
            total + answer.split { $0.isWhitespace }.count
        }
        
        let today = Date()
        if !JournalManager.shared.hasEntry(for: today) {
            userViewModel.addTeapot(amount: 5)
            userViewModel.addStreaks(amount: 1)
        }
        
        JournalManager.shared.completeEntry(for: topic)
        
        totalWritingTime = calculateWritingTime()
        showWritingRecap = true
    }
    
    private func calculateWritingTime() -> String {
        let writingEndTime = Date()
        let writingDuration = writingEndTime.timeIntervalSince(writingStartTime)
        let minutes = Int(writingDuration) / 60
        let seconds = Int(writingDuration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func regenerateQuestions(for index: Int) {
        isLoading = true
        let oldQuestion = questions[index]
        Task {
            let prompt = "I want to write a journal with a topic \(topic). Can you help me make a prompt question to help me writing? Provide me with a only one question without any following questions or additional description."
            do {
                let response = try await GenerativeModel(name: "gemini-pro", apiKey: "AIzaSyCw_Qr1xj_qgA1yQcxK_9-hZwh7Otn5k8U").generateContent(prompt)
                print("Generated Response: \(response)")
                if let text = response.text {
                    let newQuestion = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !newQuestion.isEmpty {
                        DispatchQueue.main.async {
                            // Check if the question was updated successfully
                            questions[index] = newQuestion
                            JournalManager.shared.updateQuestion(for: topic, oldQuestion: oldQuestion, newQuestion: newQuestion)
                            print("Question \(index) updated to: \(newQuestion)")
                        }
                    }
                }
            } catch {
                print("Error generating question: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                isLoading = false
            }
        }
    }

}

struct ActivityEntry_Previews: PreviewProvider {
    @State static var dummyQuestion = [
        "1. Question 1",
        "1. Question 2"
    ]
    static var previews: some View {
        //        ContentView()
        ActivityEntry(topic: "Topic", questions: $dummyQuestion, userViewModel: UserViewModel())
    }
}
