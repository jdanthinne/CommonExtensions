//
//  AttributedString.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 21/01/18.
//

#if os(macOS)
    import AppKit
#endif

extension NSMutableAttributedString {
    #if os(iOS)
        public func addBold(from location: Int = 0, length: Int? = nil, fontSize: CGFloat) {
            addAttribute(.font,
                         value: UIFont.boldSystemFont(ofSize: fontSize),
                         range: NSRange(location: location, length: length ?? self.length - location))
        }

        public func setFont(_ font: UIFont, from location: Int = 0, length: Int? = nil) {
            addAttribute(.font,
                         value: font,
                         range: NSRange(location: location, length: length ?? self.length - location))
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

        addAttribute(.paragraphStyle,
                     value: paragraphStyle,
                     range: NSRange(location: 0, length: length))
    }

    public func setLineSpacing(_ spacing: CGFloat, alignment: NSTextAlignment = .natural) {
        setParagraph(lineSpacing: spacing, alignment: alignment)
    }

    public func setParagraphSpacing(_ spacing: CGFloat, alignment: NSTextAlignment = .natural) {
        setParagraph(spacing: spacing, alignment: alignment)
    }

    public func setLineHeightMultiple(_ lineHeight: CGFloat, alignment: NSTextAlignment = .natural) {
        setParagraph(lineHeightMultiple: lineHeight, alignment: alignment)
    }

    #if os(iOS)
        public func setColor(_ color: UIColor, from location: Int = 0, length: Int? = nil) {
            addAttribute(.foregroundColor,
                         value: color,
                         range: NSRange(location: location, length: length ?? self.length - location))
        }
    #endif
}
