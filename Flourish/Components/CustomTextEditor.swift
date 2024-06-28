//
//  CustomTextEditor.swift
//  Flourish
//
//  Created by Agfi on 28/06/24.
//

import SwiftUI

struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditor

        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.delegate = context.coordinator
        textView.textColor = UIColor.label
        textView.text = placeholder
        textView.returnKeyType = UIReturnKeyType.done
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
