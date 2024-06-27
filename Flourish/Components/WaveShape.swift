//
//  WaveShape.swift
//  Flourish
//
//  Created by Agfi on 27/06/24.
//

import SwiftUI

struct WaveShape: Shape {
    var progress: CGFloat
    var waveHeight: CGFloat = 10

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveLength = rect.width / 4
        let yOffset = rect.height * (1 - progress)
        
        path.move(to: CGPoint(x: 0, y: yOffset))
        
        for x in stride(from: 0, to: rect.width + waveLength, by: 1) {
            let relativeX = x / waveLength
            let sine = sin(relativeX * .pi * 2)
            let y = yOffset + sine * waveHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}
