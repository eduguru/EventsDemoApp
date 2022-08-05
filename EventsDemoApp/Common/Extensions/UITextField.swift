
//
//  Created by Edwin Weru on 16/03/2020.
//  Copyright © 2020 Edwin Weru. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @objc var substituteFontName: String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: newValue, size: (self.font?.pointSize)!) }
    }
}

extension UITextField {
    func setLeftIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image

        let iconContainerView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }

    func setRightIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
        iconView.image = image

        let iconContainerView = UIView(frame: CGRect(x: -5, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
}

// MARK: -

extension UITextField {
    private func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry {
            button.setImage(UIImage(named: "ic_password_visible"), for: .normal)
        } else {
            button.setImage(UIImage(named: "ic_password_invisible"), for: .normal)
        }
    }

    func enablePasswordToggle() {
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }

    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}

// MARK: - TextFieldLabel

@IBDesignable
class MyTextFieldLabel: UITextField {
    /// Used to inset the bounds of the text field. The x values is applied as horizontal insets and the y value is applied as vertical insets.
//    private var centerInset: CGPoint = .zero {
//        didSet {
//            setNeedsLayout()
//        }
//    }

    // MARK: - UITextField

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }

    private let rightAccessoryButton: UIButton = .init(frame: .zero)

    /// Sets padding for the `rightView` from the text field's edge.
//    private var rightViewPadding: CGFloat = 0 {
//        didSet {
//            setNeedsLayout()
//        }
//    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= rightViewPadding
        return rightViewRect
    }

    /// Sets an image for the `rightView`.
//    private var rightViewImage: UIImage? {
//        didSet {
//            rightAccessoryButton.setImage(rightViewImage, for: .normal)
//            rightViewMode = rightViewImage != nil ? .always : .never
//        }
//    }

    /// Sets text for the `rightView`.
//    private var rightViewText: String? {
//        didSet {
//            rightAccessoryButton.setTitle(rightViewText, for: .normal)
//            rightAccessoryButton.setTitleColor(rightViewTintColor, for: .normal)
//            rightViewMode = rightViewText != nil ? .always : .never
//        }
//    }

    /// Sets tintColor for the `rightView`.
//    private var rightViewTintColor: UIColor? {
//        didSet {
//            if rightViewImage != nil {
//                rightAccessoryButton.tintColor = rightViewTintColor
//            }
//
//            if rightViewText != nil {
//                rightAccessoryButton.setTitleColor(rightViewTintColor, for: .normal)
//            }
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let viewModel = ViewModel(text: text, textColor: textColor, placeholder: placeholder, centerInset: centerInset, rightView: .init(image: rightViewImage, text: rightViewText, tintColor: rightViewTintColor, padding: rightViewPadding))
    }

    private func commonInit() {
        rightView = rightAccessoryButton
        rightViewMode = .never
    }

//    private func insetTextRect(forBounds bounds: CGRect) -> CGRect {
//        let insetBounds = bounds.insetBy(dx: centerInset.x, dy: centerInset.y)
//        return insetBounds
//    }

    private func insetTextRect(forBounds bounds: CGRect) -> CGRect {
        var insetBounds = bounds.insetBy(dx: centerInset.x, dy: centerInset.y)
        insetBounds.size.width -= rightViewPadding + rightAccessoryButton.bounds.width
        return insetBounds
    }

    /// Sets the center inset of the text field..
    @IBInspectable private var centerInset: CGPoint = .zero {
        didSet {
            setNeedsLayout()
        }
    }

    /// Sets padding for the `rightView` from the text field's edge.
    @IBInspectable private var rightViewPadding: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    /// Sets an image for the `rightView`.
    @IBInspectable private var rightViewImage: UIImage? {
        didSet {
            rightAccessoryButton.setImage(rightViewImage, for: .normal)
            rightViewMode = rightViewImage != nil || rightViewText != nil ? .always : .never
        }
    }

    /// Sets text for the `rightView`.
    @IBInspectable private var rightViewText: String? {
        didSet {
            rightAccessoryButton.setTitle(rightViewText, for: .normal)
            rightAccessoryButton.setTitleColor(rightViewTintColor, for: .normal)

            rightViewMode = rightViewText != nil || rightViewImage != nil ? .always : .never
        }
    }

    /// Sets tintColor for the `rightView`.
    @IBInspectable private var rightViewTintColor: UIColor? {
        didSet {
            if rightViewImage != nil {
                rightAccessoryButton.tintColor = rightViewTintColor
            }

            if rightViewText != nil {
                rightAccessoryButton.setTitleColor(rightViewTintColor, for: .normal)
            }
        }
    }
}

/// The view model containing information necessary for configuring the display of the view.
struct ViewModel {
    /// The properties that can be applied to the right view.
    struct RightView {
        /// The optional image for the right view.
        var image: UIImage?

        /// The optional text for the right view.
        var text: String?

        /// The tint color of the text and image.
        let tintColor: UIColor?

        /// The padding between the accessory text and edge of the text field.
        let padding: CGFloat
    }

    /// The text.
    var text: String?

    /// The color of the text.
    let textColor: UIColor?

    /// The placeholder text.
    let placeholder: String?

    /// Sets the center inset of the text field.
    let centerInset: CGPoint

    /// The optional `RightView` to display on the `rightView` of a `UITextField`.
    var rightView: RightView?
}
