//
//  NewEntry.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct NewEntry: View {
    @Binding var showPopup: Bool
    @Binding var showingNewEntrySheet: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VStack(spacing: 32) {
                        Text("Start self-journaling today. Dedicate a space to freely express your thoughts and reflect on your experiences.")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        VStack(spacing: 32) {
                            ForEach(JournalContents.contents, id: \.title) { content in
                                EntryCard(data: content)
                                    .onTapGesture {
                                        showingNewEntrySheet = false
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            showPopup = true
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 32)
                    .blur(radius: showPopup ? 3 : 0)
                }
                .animation(.easeInOut, value: showPopup)
                Spacer()
            }
            .background(Color.customPrimary10)
            .navigationBarTitle("New Entry")
        }
    }
}

#Preview {
    ContentView()
}
