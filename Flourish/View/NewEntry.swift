//
//  NewEntry.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

import SwiftUI

struct NewEntry: View {
    @State private var showPopup = false

    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                Text("Start self-journaling today. Dedicate a space to freely express your thoughts and reflect on your experiences.")
                    .font(.caption)
                    .foregroundColor(.gray)

                VStack(spacing: 32) {
                    ForEach(JournalContents.contents, id: \.title) { content in
                        EntryCard(data: content)
                            .onTapGesture {
                                showPopup = true
                            }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 32)
            .blur(radius: showPopup ? 3 : 0) // Apply blur effect when popup is visible

            if showPopup {
                Color.black.opacity(0.4) // Semi-transparent background
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showPopup = false
                    }

                PopupView(showPopup: $showPopup)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: showPopup)
    }
}


#Preview {
    ContentView()
}
