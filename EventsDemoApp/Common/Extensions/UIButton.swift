
//
//  Created by Edwin Weru on 16/03/2020.
//  Copyright © 2020 Edwin Weru. All rights reserved.
//

import Kingfisher
import UIKit

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1

        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount * factor, bottom: 0, right: insetAmount * factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount * factor, bottom: 0, right: -insetAmount * factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }

    /// This method sets an image and title for a UIButton and
    ///   repositions the titlePosition with respect to the button image.
    ///
    /// - Parameters:
    ///   - image: Button image
    ///   - title: Button title
    ///   - titlePosition: UIViewContentModeTop, UIViewContentModeBottom, UIViewContentModeLeft or UIViewContentModeRight
    ///   - additionalSpacing: Spacing between image and title
    ///   - state: State to apply this behaviour
    @objc func set(image: UIImage?, title: String, titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State) {
        imageView?.contentMode = .center
        setImage(image, for: state)

        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)

        titleLabel?.contentMode = .center
        setTitle(title, for: state)
    }

    /// This method sets an image and an attributed title for a UIButton and
    ///   repositions the titlePosition with respect to the button image.
    ///
    /// - Parameters:
    ///   - image: Button image
    ///   - title: Button attributed title
    ///   - titlePosition: UIViewContentModeTop, UIViewContentModeBottom, UIViewContentModeLeft or UIViewContentModeRight
    ///   - additionalSpacing: Spacing between image and title
    ///   - state: State to apply this behaviour
    @objc func set(image: UIImage?, attributedTitle title: NSAttributedString, at position: UIView.ContentMode, width spacing: CGFloat, state: UIControl.State) {
        imageView?.contentMode = .center
        setImage(image, for: state)

        adjust(title: title, at: position, with: spacing)

        titleLabel?.contentMode = .center
        setAttributedTitle(title, for: state)
    }

    // MARK: Private Methods

    private func adjust(title: NSAttributedString, at position: UIView.ContentMode, with spacing: CGFloat) {
        let imageRect: CGRect = self.imageRect(forContentRect: frame)
        let titleSize = title.size()

        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
    }

    private func adjust(title: NSString, at position: UIView.ContentMode, with spacing: CGFloat) {
        let imageRect: CGRect = self.imageRect(forContentRect: frame)

        // Use predefined font, otherwise use the default
        let titleFont: UIFont = titleLabel?.font ?? UIFont()
        let titleSize: CGSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont])

        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
    }

    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode, spacing: CGFloat) {
        let imageRect: CGRect = self.imageRect(forContentRect: frame)

        // Use predefined font, otherwise use the default
        let titleFont: UIFont = titleLabel?.font ?? UIFont()
        let titleSize: CGSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont])

        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
    }

    private func arrange(titleSize: CGSize, imageRect: CGRect, atPosition position: UIView.ContentMode, withSpacing spacing: CGFloat) {
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets

        switch position {
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: imageRect.height + titleSize.height + spacing, left: -(imageRect.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageRect.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        titleEdgeInsets = titleInsets
        imageEdgeInsets = imageInsets
    }
}

class ImageBarButton: UIView {
    var imageView: UIImageView!
    var button: UIButton!

    convenience init(withUrl imageURL: URL? = nil, withImage image: UIImage? = nil, frame: CGRect = CGRect(x: 0, y: 0, width: 40, height: 40)) {
        self.init(frame: frame)

        imageView = UIImageView(frame: frame)
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = frame.height / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)

        button = UIButton(frame: frame)
        button.backgroundColor = .clear
        button.setTitle("", for: .normal)
        addSubview(button)

        if let image_url = imageURL {
            self.imageView.kf.indicatorType = .activity
            self.imageView.kf.setImage(
                with: image_url,
                placeholder: UIImage(named: "littlelogo"),
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ], completionHandler: {
                    result in
                    switch result {
                    case let .success(value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case let .failure(error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
            )

            self.imageView.contentMode = .scaleAspectFit
            self.imageView.clipsToBounds = false

            self.imageView.makeRounded()
        }
    }

    func load() -> UIBarButtonItem {
        return UIBarButtonItem(customView: self)
    }
}

// MARK: -

class BadgeButton: UIButton {
    var badgeLabel = UILabel()

    var badge: String? {
        didSet {
            addBadgeToButon(badge: badge)
        }
    }

    public var badgeBackgroundColor = UIColor.red {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }

    public var badgeTextColor = UIColor.white {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }

    public var badgeFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            badgeLabel.font = badgeFont
        }
    }

    public var badgeEdgeInsets: UIEdgeInsets? {
        didSet {
            addBadgeToButon(badge: badge)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // custom logic goes here
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addBadgeToButon(badge: nil)
    }

    func addBadgeToButon(badge: String?) {
        badgeLabel.text = badge
        badgeLabel.textColor = badgeTextColor
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.font = badgeFont
        badgeLabel.sizeToFit()
        badgeLabel.textAlignment = .center
        let badgeSize = badgeLabel.frame.size

        let height = max(18, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)

        var vertical: Double?, horizontal: Double?
        if let badgeInset = self.badgeEdgeInsets {
            vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
            horizontal = Double(badgeInset.left) - Double(badgeInset.right)

            let x = (Double(bounds.size.width) - 10 + horizontal!)
            let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
            badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            let x = self.frame.width - CGFloat(width / 2.0)
            let y = CGFloat(-(height / 2.0))
            badgeLabel.frame = CGRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height))
        }

        badgeLabel.layer.cornerRadius = badgeLabel.frame.height / 2
        badgeLabel.layer.masksToBounds = true
        addSubview(badgeLabel)
        badgeLabel.isHidden = badge != nil ? false : true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addBadgeToButon(badge: nil)

        // fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.7, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height / 2

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.titleLabel?.textColor = UIColor.white

        self.sizeToFit()
    }
}
