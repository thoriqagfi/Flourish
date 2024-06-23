//
//  NewEntry.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct NewEntry: View {
    var body: some View {
        VStack(spacing: 32, content: {
            Text("Start self-journaling today. Dedicate a space to freely express your thoughts and reflect on your experiences.")
                .font(.caption)
                .foregroundStyle(.gray)
            VStack(spacing: 32) {
                ForEach(JournalContents.contents, id: \.title) { content in
                    EntryCard(data: content)
                }
            }
        })
        .padding(.horizontal, 20)
        .padding(.vertical, 32)
    }
}

#Preview {
    ContentView()
}
