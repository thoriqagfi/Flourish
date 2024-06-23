//
//  EntryCard.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct EntryCard: View {
    var data: EntryCardData
    
    var body: some View {
        HStack(alignment: .center, spacing: 20, content: {
            Image(data.image)
            VStack(alignment: .leading, spacing: 4, content: {
                Text(data.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(data.description)
                    .font(.caption)
                    .foregroundStyle(.gray)
            })
            .frame(width: 237, alignment: .topLeading)
        })
        .padding(16)
        .background(Color(.white))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.08), radius: 7.5, x: 0, y: 0)
    }
}

#Preview {
    ContentView()
}
