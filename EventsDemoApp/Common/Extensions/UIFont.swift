//
//  UIFont.swift
//  Little Agent
//
//  Created by edwin weru on 17/12/2020.
//

import Foundation
import UIKit

extension UIFont {
    class func appRegularFontWith(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Regular", size: size)!
    }

    class func appBoldFontWith(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Bold", size: size)!
    }
}
