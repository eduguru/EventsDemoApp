
//
//  Created by Edwin Weru on 16/03/2020.
//  Copyright © 2020 Edwin Weru. All rights reserved.
//

import CommonCrypto
import UIKit

extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }

    func replace(_ string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }

    //
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }

    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }

    // “swift string decoding to base64”
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

    // example usage
    // var str = "Hello, Agnostic Dev"
    //    if let character = str.character(at: 3) {
    //        print("I found \(character)") // I found l
    //    }
    //
    //    if let character = str.character(at: 31) {
    //        print("I found \(character)") // Will not return due to a position too large
    //    }
}

extension String {
    func md5() -> String {
        let data = Data(utf8) as NSData
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(data.bytes, CC_LONG(data.length), &hash)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }

//    var MD5: String {
//        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
//        return computed.map { String(format: "%02hhx", $0) }.joined()
//    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = self.range(of: emailRegEx, options: .regularExpression)
        let result = range != nil ? true : false
        return result
    }

    func encodeByAddingPercentEscapes() -> String? {
        var charset = CharacterSet.urlQueryAllowed
        charset.remove(charactersIn: "!*'();:@&=+$,/?%#[]")
        let encodedValue = addingPercentEncoding(withAllowedCharacters: charset)
        return encodedValue
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

// MARK: -

public extension String {
    /**
       Returns a new string made from the receiver by replacing characters which are
       reserved in a URI query with percent encoded characters.

       The following characters are not considered reserved in a URI query
       by RFC 3986:

       - Alpha "a...z" "A...Z"
       - Numberic "0...9"
       - Unreserved "-._~"

       In addition the reserved characters "/" and "?" have no reserved purpose in the
       query component of a URI so do not need to be percent escaped.

       - Returns: The encoded string, or nil if the transformation is not possible.
     */

    func stringByAddingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?"
        let allowedCharacterSet = NSMutableCharacterSet.alphanumeric()
        allowedCharacterSet.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet)
    }

    /**
     Returns a new string made from the receiver by replacing characters which are
     reserved in HTML forms (media type application/x-www-form-urlencoded) with
     percent encoded characters.

     The W3C HTML5 specification, section 4.10.22.5 URL-encoded form
     data percent encodes all characters except the following:

     - Space (0x20) is replaced by a "+" (0x2B)
     - Bytes in the range 0x2A, 0x2D, 0x2E, 0x30-0x39, 0x41-0x5A, 0x5F, 0x61-0x7A
       (alphanumeric + "*-._")
     - Parameter plusForSpace: Boolean, when true replaces space with a '+'
     otherwise uses percent encoding (%20). Default is false.

     - Returns: The encoded string, or nil if the transformation is not possible.
     */

    func stringByAddingPercentEncodingForFormData(plusForSpace: Bool = false) -> String? {
        let unreserved = "*-._"
        let allowedCharacterSet = NSMutableCharacterSet.alphanumeric()
        allowedCharacterSet.addCharacters(in: unreserved)

        if plusForSpace {
            allowedCharacterSet.addCharacters(in: " ")
        }

        var encoded = addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet)
        if plusForSpace {
            encoded = encoded?.replacingOccurrences(of: " ", with: "+")
        }
        return encoded
    }
}

extension String {
    mutating func toHtmlEncodedString() {
        guard let encodedData = self.data(using: .utf8) else {
            return
        }

        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
        ]

        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self = attributedString.string
        } catch {
            print("Error: \(error)")
        }
    }

    func toEnglishNumber() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "EN")
        guard let result = numberFormatter.number(from: self) else {
            return self
        }
        return result.stringValue
    }

    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }

    func equalIgnoreCase(_ compare: String) -> Bool {
        return self.uppercased() == compare.uppercased()
    }
}
