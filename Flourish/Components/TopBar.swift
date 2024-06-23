//
//  TopBar.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        HStack {
            HStack(spacing: 26, content: {
                HStack(spacing: 8, content: {
                    Image(systemName: "leaf")
                    Text("6 Seeds")
                })
                HStack(spacing: 8, content: {
                    Image(systemName: "flame")
                    Text("24 Streak")
                })
            })
            .foregroundColor(.customSecondary100)
            
            Spacer()
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundColor(.customPrimary100)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.customPrimary10)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    ContentView()
}
