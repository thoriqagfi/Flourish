//
//  ActivityEntry.swift
//  Flourish
//
//  Created by Riyadh on 24/06/24.
//

import SwiftUI

struct ActivityEntry: View {
    @State private var currentPage = 0
    @State private var answers: [String]
    @State private var totalWordsWritten = 0
    @State private var writingStartTime = Date()
    @State private var showWritingRecap = false
    @State private var totalWritingTime: String = "00:00"

    @Environment(\.presentationMode) var presentationMode

    var topic: String
    @Binding var questions: [String]

    @ObservedObject var userViewModel: UserViewModel
    @State private var isLoading = false

    init(topic: String, questions: Binding<[String]>, userViewModel: UserViewModel, answers: [String] = []) {
        self.topic = topic
        _questions = questions
        _answers = State(initialValue: answers.isEmpty ? Array(repeating: "", count: questions.wrappedValue.count) : answers)
        self.userViewModel = userViewModel
    }

    var body: some View {
        ScrollView {
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<questions.count, id: \.self) { index in
                        PromptedTextbox(
                            question: $questions[index],
                            answer: self.$answers[index],
                            topic: topic, isLoading: $isLoading
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

                CustomPageControl(numberOfPages: questions.count, currentPage: $currentPage)
                    .frame(width: 108, height: 25)
                    .background(Color.customPrimary10)
                    .cornerRadius(20)
                    .padding(.top, -90)

                NavigationLink(destination: WritingRecap(answers: answers, totalWords: totalWordsWritten, totalMinutes: totalWritingTime, streak: userViewModel.user.streaks), isActive: $showWritingRecap) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Question \(currentPage + 1)", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    saveIncompleteEntry()
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
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "teks") ?? .black]
        
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

    private func saveIncompleteEntry() {
        JournalManager.shared.saveEntry(topic: topic, questions: questions, answers: answers)
    }

    private func calculateWritingTime() -> String {
        let writingEndTime = Date()
        let writingDuration = writingEndTime.timeIntervalSince(writingStartTime)
        let minutes = Int(writingDuration) / 60
        let seconds = Int(writingDuration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
