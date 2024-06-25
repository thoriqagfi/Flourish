//
//  PopupView.swift
//  Flourish
//
//  Created by Agfi on 24/06/24.
//

import SwiftUI
import GoogleGenerativeAI

struct PopupView: View {
    @State private var journalText: String = ""
    @State private var isLoading = false
    @State private var isNavigating = false
    @Binding var showPopup: Bool
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: "AIzaSyCw_Qr1xj_qgA1yQcxK_9-hZwh7Otn5k8U")
    @State private var topic: String = ""
    @State private var questions: [String] = []
    @State private var didGenerateQuestions = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background overlay
                Color.black.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // White frame container
                    VStack(alignment: .center, spacing: 16) {
                        Text(isLoading ? "Generate Your Prompt" : "Add your topic")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .foregroundColor(.black)
                                .frame(width: 300, height: 300)
                        } else {
                            TextField("Enter your topic here...", text: $topic)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                                .foregroundColor(.black)
                                .frame(width: 300)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                    .frame(width: 353)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                    
                    
                    HStack(spacing: 12) {
                        // Back button
                        Button(action: {
                            showPopup = false
                        }) {
                            Image(systemName: "arrowshape.turn.up.backward")
                                .foregroundColor(.black)
                                .padding(20)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                        }
                        
                        // Generate button
                        Button(action: {
                            if !isLoading {
                                generateQuestions()
                            }
                        }) {
                            Text("Generate")
                                .font(Font.custom("SF Pro", size: 20).weight(.bold))
                                .foregroundColor(isLoading ? .gray : .black)
                                .padding(.horizontal, 96)
                                .padding(.vertical, 20)
                                .background(isLoading ? Color.gray.opacity(0.18) : Color.customPrimary100)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                        }
                    }
                    .padding(.top, 14)
                }
            }
            .onChange(of: questions) { _ in
                if !questions.isEmpty && !didGenerateQuestions {
                    didGenerateQuestions = true
                    isNavigating = true
                }
            }
            .background(
                NavigationLink(
                    destination: ActivityEntry(topic: topic, questions: questions),
                    isActive: $isNavigating,
                    label: { HomeView().blur(radius: 10.0) }
                )
            )
        }
    }
    
    private func generateQuestions() {
        isLoading = true
        Task {
            let prompt = "I want to write a journal with a topic \(topic). Can you help me make a prompt question to help me writing? Provide me with 5 main questions without any following questions or additional description."
            do {
                let response = try await model.generateContent(prompt)
                if let text = response.text {
                    questions = text.split(separator: "\n").map { String($0) }
                }
            } catch {
                print("Error generating questions: \(error.localizedDescription)")
            }
            isLoading = false
            showPopup.toggle()
        }
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(showPopup: .constant(true))
    }
}

#Preview {
    ContentView()
}
