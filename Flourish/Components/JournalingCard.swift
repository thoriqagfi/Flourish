//
//  JournalingCard.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct JournalingCard: View {
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack(alignment: .center, content: {
                Text("Reflection")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("Incomplete")
                    .font(.caption2)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .cornerRadius(20)
            })
            Text("What Happened Today?")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color.secondary)
                .padding(.bottom, 4)
            Text("Today was tough. My car broke down in the middle of heavy traffic. I had to wait for a tow truck in the pouring rain, getting completely...")
                .font(.subheadline)
                .foregroundColor(Color.secondary)
                .lineLimit(3)
            
            HStack(alignment: .bottom, content: {
                Text("20.30")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Spacer()
                Image(systemName: "ellipsis")
                    .frame(width: 43, height: 43)
                    .background(Color.customPrimary30)
                    .cornerRadius(20)
            })
            .padding(.vertical, 8)
        })
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
        .padding(20)
    }
}

#Preview {
    ContentView()
}
