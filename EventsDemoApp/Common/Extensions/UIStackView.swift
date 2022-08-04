//
//  UIStackView.swift
//
//  Copyright © 2020 Edwin Weru. All rights reserved.
//
//
//  Created by edwin weru on 04/11/2020.
//

import Foundation
import UIKit

extension UIStackView {
//
//    func addBackground(color: UIColor) {
//
//        let subView = UIView(frame: bounds)
//        subView.backgroundColor = color
//        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        insertSubview(subView, at: 0)
//    }
//
    func addBackground(color: UIColor, cornerRadius: CGFloat = 0) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.cornerRadius = cornerRadius

//        cardView.layer.shadowColor = UIColor.gray.cgColor
//        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        cardView.layer.shadowOpacity = 0.7

        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        insertSubview(subView, at: 0)
    }

    // and we do it here
    override open var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }

        set {
            super.backgroundColor = newValue

            let tag = -9999
            for view in subviews where view.tag == tag {
                view.removeFromSuperview()
            }

            let subView = UIView()
            subView.tag = tag
            subView.backgroundColor = newValue
            subView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subView)
            subView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            subView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            subView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            subView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }
    }
}
