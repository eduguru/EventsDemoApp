//
//  MaterialColors.swift
//
//  Based on https://github.com/daktales/MaterialDesignColorsSwift/
//
//  The MIT License (MIT)
//
//  Created by Edwin Weru on 16/03/2020.
//  Copyright © 2020 Edwin Weru. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the “Software”), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(rgba: UInt) {
        let rgba = min(rgba, 0xFFFF_FFFF)
        let red = CGFloat((rgba & 0xFF00_0000) >> 24) / 255.0
        let green = CGFloat((rgba & 0x00FF_0000) >> 16) / 255.0
        let blue = CGFloat((rgba & 0x0000_FF00) >> 8) / 255.0
        let alpha = CGFloat((rgba & 0x0000_00FF) >> 0) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

public struct MaterialColor: Hashable {
    public let name: String
    public let color: UIColor
    public let textColor: UIColor

    public var hashValue: Int {
        return name.hashValue + color.hashValue + textColor.hashValue
    }

    internal init(name: String, color: UIColor, textColor: UIColor) {
        self.name = name
        self.color = color
        self.textColor = textColor
    }

    internal init(name: String, color: UInt, textColor: UInt) {
        self.init(name: name, color: UIColor(rgba: color), textColor: UIColor(rgba: textColor))
    }
}

public func == (lhs: MaterialColor, rhs: MaterialColor) -> Bool {
    return lhs.name == rhs.name &&
        lhs.color == rhs.color &&
        lhs.textColor == rhs.textColor
}

open class MaterialColorGroup: Hashable, Collection {
    public let name: String
    public let P50: MaterialColor
    public let P100: MaterialColor
    public let P200: MaterialColor
    public let P300: MaterialColor
    public let P400: MaterialColor
    public let P500: MaterialColor
    public let P600: MaterialColor
    public let P700: MaterialColor
    public let P800: MaterialColor
    public let P900: MaterialColor

    open var colors: [MaterialColor] {
        return [P50, P100, P200, P300, P400, P500, P600, P700, P800, P900]
    }

    open var primaryColor: MaterialColor {
        return P500
    }

    open var hashValue: Int {
        return name.hashValue + colors.reduce(0) { $0 + $1.hashValue }
    }

    open var startIndex: Int {
        return 0
    }

    open var endIndex: Int {
        return colors.count
    }

    open subscript(i: Int) -> MaterialColor {
        return colors[i]
    }

    /// Returns the position immediately after the given index.
    ///
    /// The successor of an index must be well defined. For an index `i` into a
    /// collection `c`, calling `c.index(after: i)` returns the same index every
    /// time.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    open func index(after i: Int) -> Int {
        if i < self.endIndex {
            return i + 1
        }
        return self.endIndex
    }

    internal init(name: String,
                  _ P50: MaterialColor,
                  _ P100: MaterialColor,
                  _ P200: MaterialColor,
                  _ P300: MaterialColor,
                  _ P400: MaterialColor,
                  _ P500: MaterialColor,
                  _ P600: MaterialColor,
                  _ P700: MaterialColor,
                  _ P800: MaterialColor,
                  _ P900: MaterialColor)
    {
        self.name = name

        self.P50 = P50
        self.P100 = P100
        self.P200 = P200
        self.P300 = P300
        self.P400 = P400
        self.P500 = P500
        self.P600 = P600
        self.P700 = P700
        self.P800 = P800
        self.P900 = P900
    }

    open func colorForName(_ name: String) -> MaterialColor? {
        return colors.filter { $0.name == name }.first
    }
}

public func == (lhs: MaterialColorGroup, rhs: MaterialColorGroup) -> Bool {
    return lhs.name == rhs.name &&
        lhs.colors == rhs.colors
}

open class MaterialColorGroupWithAccents: MaterialColorGroup {
    public let A100: MaterialColor
    public let A200: MaterialColor
    public let A400: MaterialColor
    public let A700: MaterialColor

    open var accents: [MaterialColor] {
        return [A100, A200, A400, A700]
    }

    override open var hashValue: Int {
        return super.hashValue + accents.reduce(0) { $0 + $1.hashValue }
    }

    override open var endIndex: Int {
        return colors.count + accents.count
    }

    override open subscript(i: Int) -> MaterialColor {
        return (colors + accents)[i]
    }

    internal init(name: String,
                  _ P50: MaterialColor,
                  _ P100: MaterialColor,
                  _ P200: MaterialColor,
                  _ P300: MaterialColor,
                  _ P400: MaterialColor,
                  _ P500: MaterialColor,
                  _ P600: MaterialColor,
                  _ P700: MaterialColor,
                  _ P800: MaterialColor,
                  _ P900: MaterialColor,
                  _ A100: MaterialColor,
                  _ A200: MaterialColor,
                  _ A400: MaterialColor,
                  _ A700: MaterialColor)
    {
        self.A100 = A100
        self.A200 = A200
        self.A400 = A400
        self.A700 = A700

        super.init(name: name, P50, P100, P200, P300, P400, P500, P600, P700, P800, P900)
    }

    override open func colorForName(_ name: String) -> MaterialColor? {
        return (colors + accents).filter { $0.name == name }.first
    }
}

func == (lhs: MaterialColorGroupWithAccents, rhs: MaterialColorGroupWithAccents) -> Bool {
    return (lhs as MaterialColorGroup) == (rhs as MaterialColorGroup) &&
        lhs.accents == rhs.accents
}

public enum MaterialColors {
    public static let Red = MaterialColorGroupWithAccents(name: "Red",
                                                          MaterialColor(name: "50", color: 0xFDE0_DCFF, textColor: 0x0000_00DE),
                                                          MaterialColor(name: "100", color: 0xF9BD_BBFF, textColor: 0x0000_00DE),
                                                          MaterialColor(name: "200", color: 0xF699_88FF, textColor: 0x0000_00DE),
                                                          MaterialColor(name: "300", color: 0xF36C_60FF, textColor: 0x0000_00DE),
                                                          MaterialColor(name: "400", color: 0xE84E_40FF, textColor: 0x0000_00DE),
                                                          MaterialColor(name: "500", color: 0xE51C_23FF, textColor: 0xFFFF_FFFF),
                                                          MaterialColor(name: "600", color: 0xDD19_1DFF, textColor: 0xFFFF_FFFF),
                                                          MaterialColor(name: "700", color: 0xD017_16FF, textColor: 0xFFFF_FFFF),
                                                          MaterialColor(name: "800", color: 0xC414_11FF, textColor: 0xFFFF_FFDE),
                                                          MaterialColor(name: "900", color: 0xB012_0AFF, textColor: 0xFFFF_FFDE),
                                                          MaterialColor(name: "A100", color: 0xFF79_97FF, textColor: 0x0000_00DE),
                                                          MaterialColor(name: "A200", color: 0xFF51_77FF, textColor: 0xFFFF_FFFF),
                                                          MaterialColor(name: "A400", color: 0xFF2D_6FFF, textColor: 0xFFFF_FFFF),
                                                          MaterialColor(name: "A700", color: 0xE000_32FF, textColor: 0xFFFF_FFFF))
    public static let Pink = MaterialColorGroupWithAccents(name: "Pink",
                                                           MaterialColor(name: "50", color: 0xFCE4_ECFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "100", color: 0xF8BB_D0FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "200", color: 0xF48F_B1FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "300", color: 0xF062_92FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "400", color: 0xEC40_7AFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "500", color: 0xE91E_63FF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "600", color: 0xD81B_60FF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "700", color: 0xC218_5BFF, textColor: 0xFFFF_FFDE),
                                                           MaterialColor(name: "800", color: 0xAD14_57FF, textColor: 0xFFFF_FFDE),
                                                           MaterialColor(name: "900", color: 0x880E_4FFF, textColor: 0xFFFF_FFDE),
                                                           MaterialColor(name: "A100", color: 0xFF80_ABFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A200", color: 0xFF40_81FF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "A400", color: 0xF500_57FF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "A700", color: 0xC511_62FF, textColor: 0xFFFF_FFFF))
    public static let Purple = MaterialColorGroupWithAccents(name: "Purple",
                                                             MaterialColor(name: "50", color: 0xF3E5_F5FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "100", color: 0xE1BE_E7FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "200", color: 0xCE93_D8FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "300", color: 0xBA68_C8FF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "400", color: 0xAB47_BCFF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "500", color: 0x9C27_B0FF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "600", color: 0x8E24_AAFF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "700", color: 0x7B1F_A2FF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "800", color: 0x6A1B_9AFF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "900", color: 0x4A14_8CFF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "A100", color: 0xEA80_FCFF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "A200", color: 0xE040_FBFF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "A400", color: 0xD500_F9FF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "A700", color: 0xAA00_FFFF, textColor: 0xFFFF_FFFF))
    public static let DeepPurple = MaterialColorGroupWithAccents(name: "Deep Purple",
                                                                 MaterialColor(name: "50", color: 0xEDE7_F6FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "100", color: 0xD1C4_E9FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "200", color: 0xB39D_DBFF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "300", color: 0x9575_CDFF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "400", color: 0x7E57_C2FF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "500", color: 0x673A_B7FF, textColor: 0xFFFF_FFDE),
                                                                 MaterialColor(name: "600", color: 0x5E35_B1FF, textColor: 0xFFFF_FFDE),
                                                                 MaterialColor(name: "700", color: 0x512D_A8FF, textColor: 0xFFFF_FFDE),
                                                                 MaterialColor(name: "800", color: 0x4527_A0FF, textColor: 0xFFFF_FFDE),
                                                                 MaterialColor(name: "900", color: 0x311B_92FF, textColor: 0xFFFF_FFDE),
                                                                 MaterialColor(name: "A100", color: 0xB388_FFFF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "A200", color: 0x7C4D_FFFF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "A400", color: 0x651F_FFFF, textColor: 0xFFFF_FFDE),
                                                                 MaterialColor(name: "A700", color: 0x6200_EAFF, textColor: 0xFFFF_FFDE))
    public static let Indigo = MaterialColorGroupWithAccents(name: "Indigo",
                                                             MaterialColor(name: "50", color: 0xE8EA_F6FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "100", color: 0xC5CA_E9FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "200", color: 0x9FA8_DAFF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "300", color: 0x7986_CBFF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "400", color: 0x5C6B_C0FF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "500", color: 0x3F51_B5FF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "600", color: 0x3949_ABFF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "700", color: 0x303F_9FFF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "800", color: 0x2835_93FF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "900", color: 0x1A23_7EFF, textColor: 0xFFFF_FFDE),
                                                             MaterialColor(name: "A100", color: 0x8C9E_FFFF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "A200", color: 0x536D_FEFF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "A400", color: 0x3D5A_FEFF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "A700", color: 0x304F_FEFF, textColor: 0xFFFF_FFDE))
    public static let Blue = MaterialColorGroupWithAccents(name: "Blue",
                                                           MaterialColor(name: "50", color: 0xE7E9_FDFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "100", color: 0xD0D9_FFFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "200", color: 0xAFBF_FFFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "300", color: 0x91A7_FFFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "400", color: 0x738F_FEFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "500", color: 0x5677_FCFF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "600", color: 0x4E6C_EFFF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "700", color: 0x455E_DEFF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "800", color: 0x3B50_CEFF, textColor: 0xFFFF_FFDE),
                                                           MaterialColor(name: "900", color: 0x2A36_B1FF, textColor: 0xFFFF_FFDE),
                                                           MaterialColor(name: "A100", color: 0xA6BA_FFFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A200", color: 0x6889_FFFF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "A400", color: 0x4D73_FFFF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "A700", color: 0x4D69_FFFF, textColor: 0xFFFF_FFFF))
    public static let LightBlue = MaterialColorGroupWithAccents(name: "Light Blue",
                                                                MaterialColor(name: "50", color: 0xE1F5_FEFF, textColor: 0x0000_00DE),
                                                                MaterialColor(name: "100", color: 0xB3E5_FCFF, textColor: 0x0000_00DE),
                                                                MaterialColor(name: "200", color: 0x81D4_FAFF, textColor: 0x0000_00DE),
                                                                MaterialColor(name: "300", color: 0x4FC3_F7FF, textColor: 0x0000_00DE),
                                                                MaterialColor(name: "400", color: 0x29B6_F6FF, textColor: 0x0000_00DE),
                                                                MaterialColor(name: "500", color: 0x03A9_F4FF, textColor: 0xFFFF_FFFF),
                                                                MaterialColor(name: "600", color: 0x039B_E5FF, textColor: 0xFFFF_FFFF),
                                                                MaterialColor(name: "700", color: 0x0288_D1FF, textColor: 0xFFFF_FFFF),
                                                                MaterialColor(name: "800", color: 0x0277_BDFF, textColor: 0xFFFF_FFFF),
                                                                MaterialColor(name: "900", color: 0x0157_9BFF, textColor: 0xFFFF_FFDE),
                                                                MaterialColor(name: "A100", color: 0x80D8_FFFF, textColor: 0x0000_00DE),
                                                                MaterialColor(name: "A200", color: 0x40C4_FFFF, textColor: 0x0000_00DE),
                                                                MaterialColor(name: "A400", color: 0x00B0_FFFF, textColor: 0x0000_00DE),
                                                                MaterialColor(name: "A700", color: 0x0091_EAFF, textColor: 0xFFFF_FFFF))
    public static let Cyan = MaterialColorGroupWithAccents(name: "Cyan",
                                                           MaterialColor(name: "50", color: 0xE0F7_FAFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "100", color: 0xB2EB_F2FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "200", color: 0x80DE_EAFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "300", color: 0x4DD0_E1FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "400", color: 0x26C6_DAFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "500", color: 0x00BC_D4FF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "600", color: 0x00AC_C1FF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "700", color: 0x0097_A7FF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "800", color: 0x0083_8FFF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "900", color: 0x0060_64FF, textColor: 0xFFFF_FFDE),
                                                           MaterialColor(name: "A100", color: 0x84FF_FFFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A200", color: 0x18FF_FFFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A400", color: 0x00E5_FFFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A700", color: 0x00B8_D4FF, textColor: 0x0000_00DE))
    public static let Teal = MaterialColorGroupWithAccents(name: "Teal", // Shoutout to Teal Deer!
                                                           MaterialColor(name: "50", color: 0xE0F2_F1FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "100", color: 0xB2DF_DBFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "200", color: 0x80CB_C4FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "300", color: 0x4DB6_ACFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "400", color: 0x26A6_9AFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "500", color: 0x0096_88FF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "600", color: 0x0089_7BFF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "700", color: 0x0079_6BFF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "800", color: 0x0069_5CFF, textColor: 0xFFFF_FFDE),
                                                           MaterialColor(name: "900", color: 0x004D_40FF, textColor: 0xFFFF_FFDE),
                                                           MaterialColor(name: "A100", color: 0xA7FF_EBFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A200", color: 0x64FF_DAFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A400", color: 0x1DE9_B6FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A700", color: 0x00BF_A5FF, textColor: 0x0000_00DE))
    public static let Green = MaterialColorGroupWithAccents(name: "Green",
                                                            MaterialColor(name: "50", color: 0xD0F8_CEFF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "100", color: 0xA3E9_A4FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "200", color: 0x72D5_72FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "300", color: 0x42BD_41FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "400", color: 0x2BAF_2BFF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "500", color: 0x259B_24FF, textColor: 0xFFFF_FFFF),
                                                            MaterialColor(name: "600", color: 0x0A8F_08FF, textColor: 0xFFFF_FFFF),
                                                            MaterialColor(name: "700", color: 0x0A7E_07FF, textColor: 0xFFFF_FFFF),
                                                            MaterialColor(name: "800", color: 0x056F_00FF, textColor: 0xFFFF_FFDE),
                                                            MaterialColor(name: "900", color: 0x0D53_02FF, textColor: 0xFFFF_FFDE),
                                                            MaterialColor(name: "A100", color: 0xA2F7_8DFF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "A200", color: 0x5AF1_58FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "A400", color: 0x14E7_15FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "A700", color: 0x12C7_00FF, textColor: 0x0000_00DE))
    public static let LightGreen = MaterialColorGroupWithAccents(name: "Light Green",
                                                                 MaterialColor(name: "50", color: 0xF1F8_E9FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "100", color: 0xDCED_C8FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "200", color: 0xC5E1_A5FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "300", color: 0xAED5_81FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "400", color: 0x9CCC_65FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "500", color: 0x8BC3_4AFF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "600", color: 0x7CB3_42FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "700", color: 0x689F_38FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "800", color: 0x558B_2FFF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "900", color: 0x3369_1EFF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "A100", color: 0xCCFF_90FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "A200", color: 0xB2FF_59FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "A400", color: 0x76FF_03FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "A700", color: 0x64DD_17FF, textColor: 0x0000_00DE))
    public static let Lime = MaterialColorGroupWithAccents(name: "Lime",
                                                           MaterialColor(name: "50", color: 0xF9FB_E7FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "100", color: 0xF0F4_C3FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "200", color: 0xE6EE_9CFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "300", color: 0xDCE7_75FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "400", color: 0xD4E1_57FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "500", color: 0xCDDC_39FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "600", color: 0xC0CA_33FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "700", color: 0xAFB4_2BFF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "800", color: 0x9E9D_24FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "900", color: 0x8277_17FF, textColor: 0xFFFF_FFFF),
                                                           MaterialColor(name: "A100", color: 0xF4FF_81FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A200", color: 0xEEFF_41FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A400", color: 0xC6FF_00FF, textColor: 0x0000_00DE),
                                                           MaterialColor(name: "A700", color: 0xAEEA_00FF, textColor: 0x0000_00DE))
    public static let Yellow = MaterialColorGroupWithAccents(name: "Yellow",
                                                             MaterialColor(name: "50", color: 0xFFFD_E7FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "100", color: 0xFFF9_C4FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "200", color: 0xFFF5_9DFF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "300", color: 0xFFF1_76FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "400", color: 0xFFEE_58FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "500", color: 0xFFEB_3BFF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "600", color: 0xFDD8_35FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "700", color: 0xFBC0_2DFF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "800", color: 0xF9A8_25FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "900", color: 0xF57F_17FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "A100", color: 0xFFFF_8DFF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "A200", color: 0xFFFF_00FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "A400", color: 0xFFEA_00FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "A700", color: 0xFFD6_00FF, textColor: 0x0000_00DE))
    public static let Amber = MaterialColorGroupWithAccents(name: "Amber",
                                                            MaterialColor(name: "50", color: 0xFFF8_E1FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "100", color: 0xFFEC_B3FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "200", color: 0xFFE0_82FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "300", color: 0xFFD5_4FFF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "400", color: 0xFFCA_28FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "500", color: 0xFFC1_07FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "600", color: 0xFFB3_00FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "700", color: 0xFFA0_00FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "800", color: 0xFF8F_00FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "900", color: 0xFF6F_00FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "A100", color: 0xFFE5_7FFF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "A200", color: 0xFFD7_40FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "A400", color: 0xFFC4_00FF, textColor: 0x0000_00DE),
                                                            MaterialColor(name: "A700", color: 0xFFAB_00FF, textColor: 0x0000_00DE))
    public static let Orange = MaterialColorGroupWithAccents(name: "Orange",
                                                             MaterialColor(name: "50", color: 0xFFF3_E0FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "100", color: 0xFFE0_B2FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "200", color: 0xFFCC_80FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "300", color: 0xFFB7_4DFF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "400", color: 0xFFA7_26FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "500", color: 0xFF98_00FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "600", color: 0xFB8C_00FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "700", color: 0xF57C_00FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "800", color: 0xEF6C_00FF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "900", color: 0xE651_00FF, textColor: 0xFFFF_FFFF),
                                                             MaterialColor(name: "A100", color: 0xFFD1_80FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "A200", color: 0xFFAB_40FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "A400", color: 0xFF91_00FF, textColor: 0x0000_00DE),
                                                             MaterialColor(name: "A700", color: 0xFF6D_00FF, textColor: 0x0000_0000))
    public static let DeepOrange = MaterialColorGroupWithAccents(name: "Deep Orange",
                                                                 MaterialColor(name: "50", color: 0xFBE9_E7FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "100", color: 0xFFCC_BCFF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "200", color: 0xFFAB_91FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "300", color: 0xFF8A_65FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "400", color: 0xFF70_43FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "500", color: 0xFF57_22FF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "600", color: 0xF451_1EFF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "700", color: 0xE64A_19FF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "800", color: 0xD843_15FF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "900", color: 0xBF36_0CFF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "A100", color: 0xFF9E_80FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "A200", color: 0xFF6E_40FF, textColor: 0x0000_00DE),
                                                                 MaterialColor(name: "A400", color: 0xFF3D_00FF, textColor: 0xFFFF_FFFF),
                                                                 MaterialColor(name: "A700", color: 0xDD2C_00FF, textColor: 0xFFFF_FFFF))
    public static let Brown = MaterialColorGroup(name: "Brown",
                                                 MaterialColor(name: "50", color: 0xEFEB_E9FF, textColor: 0x0000_00DE),
                                                 MaterialColor(name: "100", color: 0xD7CC_C8FF, textColor: 0x0000_00DE),
                                                 MaterialColor(name: "200", color: 0xBCAA_A4FF, textColor: 0x0000_00DE),
                                                 MaterialColor(name: "300", color: 0xA188_7FFF, textColor: 0xFFFF_FFFF),
                                                 MaterialColor(name: "400", color: 0x8D6E_63FF, textColor: 0xFFFF_FFFF),
                                                 MaterialColor(name: "500", color: 0x7955_48FF, textColor: 0xFFFF_FFDE),
                                                 MaterialColor(name: "600", color: 0x6D4C_41FF, textColor: 0xFFFF_FFDE),
                                                 MaterialColor(name: "700", color: 0x5D40_37FF, textColor: 0xFFFF_FFDE),
                                                 MaterialColor(name: "800", color: 0x4E34_2EFF, textColor: 0xFFFF_FFDE),
                                                 MaterialColor(name: "900", color: 0x3E27_23FF, textColor: 0xFFFF_FFDE))
    public static let Grey = MaterialColorGroup(name: "Grey",
                                                MaterialColor(name: "50", color: 0xFAFA_FAFF, textColor: 0x0000_00DE),
                                                MaterialColor(name: "100", color: 0xF5F5_F5FF, textColor: 0x0000_00DE),
                                                MaterialColor(name: "200", color: 0xEEEE_EEFF, textColor: 0x0000_00DE),
                                                MaterialColor(name: "300", color: 0xE0E0_E0FF, textColor: 0x0000_00DE),
                                                MaterialColor(name: "400", color: 0xBDBD_BDFF, textColor: 0x0000_00DE),
                                                MaterialColor(name: "500", color: 0x9E9E_9EFF, textColor: 0x0000_00DE),
                                                MaterialColor(name: "600", color: 0x7575_75FF, textColor: 0xFFFF_FFDE),
                                                MaterialColor(name: "700", color: 0x6161_61FF, textColor: 0xFFFF_FFDE),
                                                MaterialColor(name: "800", color: 0x4242_42FF, textColor: 0xFFFF_FFDE),
                                                MaterialColor(name: "900", color: 0x2121_21FF, textColor: 0xFFFF_FFDE))
    public static let BlueGrey = MaterialColorGroup(name: "Blue Grey",
                                                    MaterialColor(name: "50", color: 0xECEF_F1FF, textColor: 0x0000_00DE),
                                                    MaterialColor(name: "100", color: 0xCFD8_DCFF, textColor: 0x0000_00DE),
                                                    MaterialColor(name: "200", color: 0xB0BE_C5FF, textColor: 0x0000_00DE),
                                                    MaterialColor(name: "300", color: 0x90A4_AEFF, textColor: 0x0000_00DE),
                                                    MaterialColor(name: "400", color: 0x7890_9CFF, textColor: 0xFFFF_FFFF),
                                                    MaterialColor(name: "500", color: 0x607D_8BFF, textColor: 0xFFFF_FFFF),
                                                    MaterialColor(name: "600", color: 0x546E_7AFF, textColor: 0xFFFF_FFDE),
                                                    MaterialColor(name: "700", color: 0x455A_64FF, textColor: 0xFFFF_FFDE),
                                                    MaterialColor(name: "800", color: 0x3747_4FFF, textColor: 0xFFFF_FFDE),
                                                    MaterialColor(name: "900", color: 0x2632_38FF, textColor: 0xFFFF_FFDE))
    public static let Black = MaterialColor(name: "Black", color: 0x0000_00FF, textColor: 0xFFFF_FFDE)
    public static let White = MaterialColor(name: "White", color: 0xFFFF_FFFF, textColor: 0x0000_00DE)

    public static let accentedColorGroups: [MaterialColorGroupWithAccents] = [
        Red, Pink, Purple, DeepPurple, Indigo, Blue, LightBlue, Cyan, Teal,
        Green, LightGreen, Lime, Yellow, Amber, Orange, DeepOrange
    ]
    public static let unaccentedColorGroups: [MaterialColorGroup] = [
        Brown, Grey, BlueGrey
    ]
    public static let colorGroups: [MaterialColorGroup] = accentedColorGroups + unaccentedColorGroups

    public static let P50: [MaterialColor] = [
        Red.P50, Pink.P50, Purple.P50, DeepPurple.P50, Indigo.P50,
        Blue.P50, LightBlue.P50, Cyan.P50, Teal.P50, Green.P50,
        LightGreen.P50, Lime.P50, Yellow.P50, Amber.P50, Orange.P50,
        DeepOrange.P50, Brown.P50, Grey.P50, BlueGrey.P50
    ]
    public static let P100: [MaterialColor] = [
        Red.P100, Pink.P100, Purple.P100, DeepPurple.P100, Indigo.P100,
        Blue.P100, LightBlue.P100, Cyan.P100, Teal.P100, Green.P100,
        LightGreen.P100, Lime.P100, Yellow.P100, Amber.P100, Orange.P100,
        DeepOrange.P100, Brown.P100, Grey.P100, BlueGrey.P100
    ]
    public static let P200: [MaterialColor] = [
        Red.P200, Pink.P200, Purple.P200, DeepPurple.P200, Indigo.P200,
        Blue.P200, LightBlue.P200, Cyan.P200, Teal.P200, Green.P200,
        LightGreen.P200, Lime.P200, Yellow.P200, Amber.P200, Orange.P200,
        DeepOrange.P200, Brown.P200, Grey.P200, BlueGrey.P200
    ]
    public static let P300: [MaterialColor] = [
        Red.P300, Pink.P300, Purple.P300, DeepPurple.P300, Indigo.P300,
        Blue.P300, LightBlue.P300, Cyan.P300, Teal.P300, Green.P300,
        LightGreen.P300, Lime.P300, Yellow.P300, Amber.P300, Orange.P300,
        DeepOrange.P300, Brown.P300, Grey.P300, BlueGrey.P300
    ]
    public static let P400: [MaterialColor] = [
        Red.P400, Pink.P400, Purple.P400, DeepPurple.P400, Indigo.P400,
        Blue.P400, LightBlue.P400, Cyan.P400, Teal.P400, Green.P400,
        LightGreen.P400, Lime.P400, Yellow.P400, Amber.P400, Orange.P400,
        DeepOrange.P400, Brown.P400, Grey.P400, BlueGrey.P400
    ]
    public static let P500: [MaterialColor] = [
        Red.P500, Pink.P500, Purple.P500, DeepPurple.P500, Indigo.P500,
        Blue.P500, LightBlue.P500, Cyan.P500, Teal.P500, Green.P500,
        LightGreen.P500, Lime.P500, Yellow.P500, Amber.P500, Orange.P500,
        DeepOrange.P500, Brown.P500, Grey.P500, BlueGrey.P500
    ]
    public static let P600: [MaterialColor] = [
        Red.P600, Pink.P600, Purple.P600, DeepPurple.P600, Indigo.P600,
        Blue.P600, LightBlue.P600, Cyan.P600, Teal.P600, Green.P600,
        LightGreen.P600, Lime.P600, Yellow.P600, Amber.P600, Orange.P600,
        DeepOrange.P600, Brown.P600, Grey.P600, BlueGrey.P600
    ]
    public static let P700: [MaterialColor] = [
        Red.P700, Pink.P700, Purple.P700, DeepPurple.P700, Indigo.P700,
        Blue.P700, LightBlue.P700, Cyan.P700, Teal.P700, Green.P700,
        LightGreen.P700, Lime.P700, Yellow.P700, Amber.P700, Orange.P700,
        DeepOrange.P700, Brown.P700, Grey.P700, BlueGrey.P700
    ]
    public static let P800: [MaterialColor] = [
        Red.P800, Pink.P800, Purple.P800, DeepPurple.P800, Indigo.P800,
        Blue.P800, LightBlue.P800, Cyan.P800, Teal.P800, Green.P800,
        LightGreen.P800, Lime.P800, Yellow.P800, Amber.P800, Orange.P800,
        DeepOrange.P800, Brown.P800, Grey.P800, BlueGrey.P800
    ]
    public static let P900: [MaterialColor] = [
        Red.P900, Pink.P900, Purple.P900, DeepPurple.P900, Indigo.P900,
        Blue.P900, LightBlue.P900, Cyan.P900, Teal.P900, Green.P900,
        LightGreen.P900, Lime.P900, Yellow.P900, Amber.P900, Orange.P900,
        DeepOrange.P900, Brown.P900, Grey.P900, BlueGrey.P900
    ]
    public static let A100: [MaterialColor] = [
        Red.A100, Pink.A100, Purple.A100, DeepPurple.A100, Indigo.A100,
        Blue.A100, LightBlue.A100, Cyan.A100, Teal.A100, Green.A100,
        LightGreen.A100, Lime.A100, Yellow.A100, Amber.A100, Orange.A100,
        DeepOrange.A100
    ]
    public static let A200: [MaterialColor] = [
        Red.A200, Pink.A200, Purple.A200, DeepPurple.A200, Indigo.A200,
        Blue.A200, LightBlue.A200, Cyan.A200, Teal.A200, Green.A200,
        LightGreen.A200, Lime.A200, Yellow.A200, Amber.A200, Orange.A200,
        DeepOrange.A200
    ]
    public static let A400: [MaterialColor] = [
        Red.A400, Pink.A400, Purple.A400, DeepPurple.A400, Indigo.A400,
        Blue.A400, LightBlue.A400, Cyan.A400, Teal.A400, Green.A400,
        LightGreen.A400, Lime.A400, Yellow.A400, Amber.A400, Orange.A400,
        DeepOrange.A400
    ]
    public static let A700: [MaterialColor] = [
        Red.A700, Pink.A700, Purple.A700, DeepPurple.A700, Indigo.A700,
        Blue.A700, LightBlue.A700, Cyan.A700, Teal.A700, Green.A700,
        LightGreen.A700, Lime.A700, Yellow.A700, Amber.A700, Orange.A700,
        DeepOrange.A700
    ]
}
