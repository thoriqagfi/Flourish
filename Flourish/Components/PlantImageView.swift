//
//  PlantImageView.swift
//  Flourish
//
//  Created by Agfi on 27/06/24.
//

import SwiftUI

struct PlantImageView: View {
    var imageBackground: String
    var imageFill: String
    var amountFlushed: Int
    var countFlushedtoFinish: Int

    var body: some View {
        let progress = CGFloat(amountFlushed) / CGFloat(countFlushedtoFinish)
        
        ZStack {
            Image(imageBackground)
            
            Image(imageFill)
                .mask(
                    Rectangle()
                        .scaleEffect(x: 1, y: progress, anchor: .bottom)
                )
                .offset(x: -3.5, y: -2)
        }
    }
}

#Preview {
    PlantImageView(imageBackground: "Plant", imageFill: "Plant-fill", amountFlushed: 20, countFlushedtoFinish: 100)
}
