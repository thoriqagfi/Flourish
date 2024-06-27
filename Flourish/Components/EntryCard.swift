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
                    .lineLimit(3)
                    .opacity(0.6)
            })
            .frame(width: 237, height: 60, alignment: .topLeading)
        })
        .padding(16)
        .background(Color.customPrimary10)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.08), radius: 7.5, x: 0, y: 0)
    }
}

#Preview {
    ContentView()
}
