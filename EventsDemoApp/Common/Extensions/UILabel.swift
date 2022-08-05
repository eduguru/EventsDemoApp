//
//
//  Created by Edwin Weru on 16/03/2020.
//  Copyright © 2020 Edwin Weru. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    @objc var substituteFontName: String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of: "-Bd") == nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }

    @objc var substituteFontNameBold: String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of: "-Bd") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
}

extension UILabel {
    func addBadge(label: UILabel, badgeCount: String) {
        label.clipsToBounds = true
        label.layer.cornerRadius = label.font.pointSize * 0.60
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.text = " \(badgeCount) " // note spaces before and after text
    }

    func addBadge(label: UILabel, badgeCount: String, bgColor: UIColor) {
        label.clipsToBounds = true
        label.layer.cornerRadius = label.font.pointSize * 0.60
        label.backgroundColor = bgColor
        label.textColor = UIColor.white
        label.text = " \(badgeCount) " // note spaces before and after text
    }

    func addBadge(label: UILabel, badgeCount: String, textColor: UIColor, bgColor: UIColor) {
        label.clipsToBounds = true
        label.layer.cornerRadius = label.font.pointSize * 0.60
        label.backgroundColor = bgColor
        label.textColor = textColor
        label.text = " \(badgeCount) " // note spaces before and after text
    }
}

/// A UILabel that looks like a pill! Set background color and text color to customize the appearance.
@IBDesignable class PillUILabel: UILabel {
    /// The vertical padding to apply to the top and bottom of the view
    @IBInspectable var verticalPad: CGFloat = 0
    /// The horizontal padding to apply to the left and right of the view
    @IBInspectable var horizontalPad: CGFloat = 0

    func setup() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        textAlignment = .center
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        let newWidth = superSize.width + superSize.height + (2 * horizontalPad)
        let newHeight = superSize.height + (2 * verticalPad)
        let newSize = CGSize(width: newWidth, height: newHeight)
        return newSize
    }
}

extension UILabel {
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText

        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: (self.text?.count)! - lengthForVisibleString), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: (trimmedString?.count ?? 0) - readMoreLength, length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }

    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)

        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key: Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)

        if boundingRect.size.height > labelHeight {
            var index = 0
            var prev = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key: Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
}

// MARK: - PaddingLabel

@IBDesignable
class PaddingLabel: UILabel {
    var textEdgeInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }

    @IBInspectable
    var paddingLeft: CGFloat {
        set { textEdgeInsets.left = newValue }
        get { return textEdgeInsets.left }
    }

    @IBInspectable
    var paddingRight: CGFloat {
        set { textEdgeInsets.right = newValue }
        get { return textEdgeInsets.right }
    }

    @IBInspectable
    var paddingTop: CGFloat {
        set { textEdgeInsets.top = newValue }
        get { return textEdgeInsets.top }
    }

    @IBInspectable
    var paddingBottom: CGFloat {
        set { textEdgeInsets.bottom = newValue }
        get { return textEdgeInsets.bottom }
    }
}

extension UILabel {
    func underlineMyText(range1: String, range2: String) {
        if let textString = self.text {
            let str = NSString(string: textString)
            let firstRange = str.range(of: range1)
            let secRange = str.range(of: range2)
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: firstRange)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: secRange)
            attributedText = attributedString
        }
    }
}
