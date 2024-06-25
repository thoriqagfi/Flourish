//
//  UserStats.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import SwiftUI

struct UserStats: View {
    @State var seeds: Int
    @State var streaks: Int
    
    var body: some View {
        HStack(spacing: 26, content: {
            HStack(spacing: 8, content: {
                Image(systemName: "leaf")
                Text("\(seeds) Seeds")
            })
            HStack(spacing: 8, content: {
                Image(systemName: "flame")
                Text("\(streaks) Streak")
            })
        })
        .foregroundColor(.customSecondary100)
    }
}

#Preview {
    ContentView()
}
