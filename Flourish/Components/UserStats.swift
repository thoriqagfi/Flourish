//
//  UserStats.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import SwiftUI

struct UserStats: View {
    @State private var user: User = JournalManager.shared.getCurrentUser()
    
    var body: some View {
        HStack(spacing: 26, content: {
            HStack(spacing: 8, content: {
                Image(systemName: "leaf")
                Text("\(user.seeds) Seeds")
            })
            HStack(spacing: 8, content: {
                Image(systemName: "flame")
                Text("\(user.streaks) Streak")
            })
        })
        .foregroundColor(.customSecondary100)
    }
}

#Preview {
    ContentView()
}
