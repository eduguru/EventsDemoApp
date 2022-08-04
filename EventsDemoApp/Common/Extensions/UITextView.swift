//
//  UITextView.swift
//
//  Copyright © 2020 Edwin Weru. All rights reserved.
//
//
//  Created by edwin weru on 14/11/2020.
//

import Foundation
import UIKit

// extension UITextView {
//  private func add(_ placeholder: UILabel) {
//
//    for view in self.subviews {
//        if let lbl = view as? UILabel  {
//            if lbl.text == placeholder.text {
//                lbl.removeFromSuperview()
//            }
//        }
//    }
//    self.addSubview(placeholder)
//
//  }
//
//  func addPlaceholder(_ placeholder: UILabel?) {
//
//    if let ph = placeholder {
//      ph.numberOfLines = 0  // support for multiple lines
//      ph.font = UIFont.italicSystemFont(ofSize: (self.font?.pointSize)!)
//      ph.sizeToFit()
//      self.add(ph)
//      ph.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
//      ph.textColor = UIColor(white: 0, alpha: 0.3)
//      updateVisibility(ph)
//    }
//
//  }
//
//  func updateVisibility(_ placeHolder: UILabel?) {
//
//    if let ph = placeHolder {
//      ph.isHidden = !self.text.isEmpty
//    }
//  }
//
// }

class UIPlaceholderTextView: UITextView, UITextViewDelegate {
    var placeholderText = "placeholderText"

    override func willMove(toSuperview newSuperview: UIView?) {
        textColor = .black
        delegate = self
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            placeholderText = textView.text
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholderText
            textColor = .black
        }
    }
}
