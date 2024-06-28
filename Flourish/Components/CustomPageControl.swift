//
//  CustomPageControl.swift
//  Flourish
//
//  Created by Agfi on 28/06/24.
//

import SwiftUI

import SwiftUI
import UIKit

struct CustomPageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int

    class Coordinator: NSObject {
        var parent: CustomPageControl

        init(parent: CustomPageControl) {
            self.parent = parent
        }

        @objc func pageControlChanged(_ sender: UIPageControl) {
            parent.currentPage = sender.currentPage
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        pageControl.addTarget(context.coordinator, action: #selector(Coordinator.pageControlChanged(_:)), for: .valueChanged)
        return pageControl
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}

struct CustomPageControl_Previews: PreviewProvider {
    @State static var dummyAnswer: Int = 1
    
    static var previews: some View {
        CustomPageControl(numberOfPages: 3, currentPage: $dummyAnswer)
    }
}
