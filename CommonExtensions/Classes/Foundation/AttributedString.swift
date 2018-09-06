//
//  AttributedString.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 21/01/18.
//

extension NSMutableAttributedString {

    #if os(iOS)
    public func addBold(from location: Int = 0, length: Int? = nil, fontSize: CGFloat) {
        self.addAttribute(.font,
                          value: UIFont.boldSystemFont(ofSize: fontSize),
                          range: NSRange(location: location, length: length ?? self.length))
    }

    public func setFont(_ font: UIFont, from location: Int = 0, length: Int? = nil) {
        self.addAttribute(.font,
                          value: font,
                          range: NSRange(location: location, length: length ?? self.length))
    }
    #endif

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

    public func setLineSpacing(_ spacing: CGFloat, alignment: NSTextAlignment = .natural) {
        self.setParagraph(lineSpacing: spacing, alignment: alignment)
    }

    public func setParagraphSpacing(_ spacing: CGFloat, alignment: NSTextAlignment = .natural) {
        self.setParagraph(spacing: spacing, alignment: alignment)
    }

    public func setLineHeightMultiple(_ lineHeight: CGFloat, alignment: NSTextAlignment = .natural) {
        self.setParagraph(lineHeightMultiple: lineHeight, alignment: alignment)
    }

    #if os(iOS)
    public func setColor(_ color: UIColor, from location: Int = 0, length: Int? = nil) {
        self.addAttribute(.foregroundColor,
                          value: color,
                          range: NSRange(location: location, length: length ?? self.length))
    }
    #endif

}
