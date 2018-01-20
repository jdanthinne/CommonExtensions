//
//  Color.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension UIColor {
    
    static let mainColor: UIColor = "#FC4831".toRGB
    static let gray: UIColor = UIColor(white: 0.25, alpha: 1)
    static let placeholderText: UIColor = UIColor(white: 0.4, alpha: 1)
    static let masterSeparator = UIColor(white: 0.16, alpha: 1)
    
}

extension String {
    
    var toRGB: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
