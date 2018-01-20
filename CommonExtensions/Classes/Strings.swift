//
//  i18n.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension String {
    
    public func capitalizingFirstLetter(lowercasingRemainingLetters: Bool = false) -> String {
        var remainingLetters: String = String(dropFirst())
        
        if lowercasingRemainingLetters {
            remainingLetters = remainingLetters.lowercased(with: Locale.current)
        }
        
        return prefix(1).uppercased(with: Locale.current) + remainingLetters
    }
    
    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    public func sizeNeeded(inAvailableWidth width: CGFloat, withFont font: UIFont, withLineSpacing lineSpace: CGFloat = 0, withParagraphSpacing paragraphSpacing: CGFloat = 0, maxLines: Int = 0) -> CGRect {
        var attributes: [NSAttributedStringKey: Any] = [.font: font]
        
        if lineSpace != 0 {
            let bodyParagraphStyle = NSMutableParagraphStyle()
            bodyParagraphStyle.lineSpacing = lineSpace
            bodyParagraphStyle.paragraphSpacing = paragraphSpacing
            attributes[.paragraphStyle] = bodyParagraphStyle
        }
        
        let height: CGFloat = maxLines != 0 ? CGFloat(maxLines) * font.lineHeight : 0
        
        let spaceNeeded = NSString(string: self).boundingRect(with: CGSize(width: width, height: height), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return spaceNeeded
    }
  
}
