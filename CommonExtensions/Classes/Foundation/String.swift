//
//  String.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

import Foundation

extension String {
    
    public enum ValidationRule {
        /// Any input is valid, including an empty string.
        case noRestriction
        /// The input must not be empty.
        case nonEmpty
        /// The input must be a valid email address.
        case email
        /// The enitre input must match a regular expression. A matching substring is not enough.
        case regularExpression(NSRegularExpression)
        /// The input is valid if the predicate function returns `true`.
        case predicate((String) -> Bool)
    }
    
    public func isValid(rule: String.ValidationRule) -> Bool {
        switch rule {
        case .noRestriction:
            return true
        case .nonEmpty:
            return !self.isEmpty
        case .email:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
        case .regularExpression(let regex):
            let fullNSRange = NSRange(self.startIndex..., in: self)
            return regex.rangeOfFirstMatch(in: self, options: .anchored, range: fullNSRange) == fullNSRange
        case .predicate(let p):
            return p(self)
        }
    }

    public func capitalizingFirstLetter(lowercasingRemainingLetters: Bool = false) -> String {
        var remainingLetters: String = String(dropFirst())

        if lowercasingRemainingLetters {
            remainingLetters = remainingLetters.lowercased(with: Locale.current)
        }

        return prefix(1).uppercased(with: Locale.current) + remainingLetters
    }

    public mutating func capitalizeFirstLetter(lowercasingRemainingLetters: Bool = false) {
        self = self.capitalizingFirstLetter(lowercasingRemainingLetters: lowercasingRemainingLetters)
    }

    #if os(iOS)
    public func sizeNeeded(inAvailableWidth width: CGFloat,
                           withFont font: UIFont,
                           withLineSpacing lineSpace: CGFloat = 0,
                           withParagraphSpacing paragraphSpacing: CGFloat = 0,
                           maxLines: Int = 0) -> CGRect {
        var attributes: [NSAttributedStringKey: Any] = [.font: font]

        if lineSpace != 0 {
            let bodyParagraphStyle = NSMutableParagraphStyle()
            bodyParagraphStyle.lineSpacing = lineSpace
            bodyParagraphStyle.paragraphSpacing = paragraphSpacing
            attributes[.paragraphStyle] = bodyParagraphStyle
        }

        let height: CGFloat = maxLines != 0 ? CGFloat(maxLines) * font.lineHeight : 0

        let spaceNeeded = NSString(string: self).boundingRect(with: CGSize(width: width, height: height),
                                                              options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                              attributes: attributes, context: nil)

        return spaceNeeded
    }
    #endif
    
    public func stripTags() -> String {
        return self
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            .replacingOccurrences(of: "&nbsp;", with: "")
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

}

extension String.Index {

    public func advance(by offset: Int, for string: String) -> String.Index {
        return string.index(self, offsetBy: offset)
    }

}
