//
//  AttributedString.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 21/01/18.
//

extension NSMutableAttributedString {

    public func addBold(location: Int, length: Int, fontSize: CGFloat) {
        self.addAttribute(.font,
                          value: UIFont.boldSystemFont(ofSize: fontSize),
                          range: NSRange(location: location, length: length))
    }

    public func setFont(value: UIFont) {
        self.addAttribute(.font,
                          value: value,
                          range: NSRange(location: 0, length: self.length))
    }

    public func setParagraph(spacing: CGFloat = 0,
                             lineSpacing: CGFloat = 0,
                             lineHeightMultiple: CGFloat = 0,
                             alignment: NSTextAlignment = .natural) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = spacing
        paragraphStyle.alignment = alignment
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        self.addAttribute(.paragraphStyle,
                          value: paragraphStyle,
                          range: NSRange(location: 0, length: self.length))
    }

    public func setLineSpacing(value: CGFloat, alignment: NSTextAlignment = .natural) {
        self.setParagraph(lineSpacing: value, alignment: alignment)
    }

    public func setParagraphSpacing(value: CGFloat, alignment: NSTextAlignment = .natural) {
        self.setParagraph(spacing: value, alignment: alignment)
    }

    public func setLineHeightMultiple(value: CGFloat, alignment: NSTextAlignment = .natural) {
        self.setParagraph(lineHeightMultiple: value, alignment: alignment)
    }

    public func setColor(value: UIColor, location: Int, length: Int) {
        self.addAttribute(.foregroundColor,
                          value: value,
                          range: NSRange(location: location, length: length))
    }

    public func setColor(value: UIColor) {
        self.setColor(value: value, location: 0, length: self.length)
    }

}
