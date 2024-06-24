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
    @State private var isEditing: Bool = false // Track editing state
    @Binding var showPopup: Bool
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: "AIzaSyCw_Qr1xj_qgA1yQcxK_9-hZwh7Otn5k8U")
    @State var output: String = ""
    @State private var newMessage = ""
    
    var body: some View {
        ZStack {
            // Background overlay
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // White frame container
                VStack(alignment: .center, spacing: 16) {
                    Text("Add your topic")
                        .font(Font.custom("SF Pro", size: 20).weight(.semibold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    // TextEditor with placeholder
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $journalText)
                            .frame(width: 313, height: 187)
                            .scrollContentBackground(.hidden)
                            .background(Color.customPrimary30)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                            .onTapGesture {
                                isEditing = true
                            }
                        if journalText.isEmpty && !isEditing {
                            Text("Enter your topic here...")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 10)
                                .allowsHitTesting(false) // Prevents text from being selectable
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 20)
                .frame(width: 353)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                
                HStack(alignment: .center, spacing: 12) {
                    
                    // Back button
                    Button(action: {
                        // Action to perform when button is tapped
                        print("Back button tapped")
                        showPopup = false
                    }) {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .foregroundColor(.black)
                            .padding(20)
                            .background(Color.customPrimary30)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                    }
                    
                    // Generate button
                    Button(action: {
                        // Action to perform when button is tapped
                        print("Generate button tapped")
                        Task {
                            let prompt = "I want to write a journal with a topic \(journalText) Can you help me make a prompt question to help me writing. Provide me with 5 main question without any following question or additional description."
                            let response = try await model.generateContent(prompt)
                            if let text = response.text {
                                output = text
                            }
                        }
                    }) {
                        Text("Generate")
                            .font(Font.custom("SF Pro", size: 20).weight(.semibold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 96)
                            .padding(.vertical, 20)
                            .background(Color.customPrimary100)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                    }
                }
                .padding(.top, 14)
                
                Text("\(output)")
                    .padding(10)
                    .background(Color.white)
            }
        }
        .frame(width: 393, height: 852)
    }
}


#Preview {
    ContentView()
}
