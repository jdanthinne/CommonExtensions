//
//  Color.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

#if os(iOS)
    import UIKit

    extension UIColor {
        public convenience init(red255: Int, green255: Int, blue255: Int, alpha: CGFloat = 1) {
            self.init(red: CGFloat(red255) / 255, green: CGFloat(green255) / 255, blue: CGFloat(blue255) / 255, alpha: alpha)
        }

        public convenience init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
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
                (a, r, g, b) = (0, 0, 0, 0)
            }

            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }

        public func add(_ overlay: UIColor) -> UIColor {
            var bgR: CGFloat = 0
            var bgG: CGFloat = 0
            var bgB: CGFloat = 0
            var bgA: CGFloat = 0

            var fgR: CGFloat = 0
            var fgG: CGFloat = 0
            var fgB: CGFloat = 0
            var fgA: CGFloat = 0

            getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
            overlay.getRed(&fgR, green: &fgG, blue: &fgB, alpha: &fgA)

            let r = fgA * fgR + (1 - fgA) * bgR
            let g = fgA * fgG + (1 - fgA) * bgG
            let b = fgA * fgB + (1 - fgA) * bgB

            return UIColor(red: r, green: g, blue: b, alpha: 1.0)
        }

        public func modified(additionalHue hue: CGFloat = 0, additionalSaturation: CGFloat = 0, additionalBrightness: CGFloat = 0) -> UIColor {
            var currentHue: CGFloat = 0.0
            var currentSaturation: CGFloat = 0.0
            var currentBrigthness: CGFloat = 0.0
            var currentAlpha: CGFloat = 0.0

            if getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha) {
                return UIColor(hue: currentHue + hue,
                               saturation: currentSaturation + additionalSaturation,
                               brightness: currentBrigthness + additionalBrightness,
                               alpha: currentAlpha)
            } else {
                return self
            }
        }

        public func darkModeFriendly(force: Bool = false) -> UIColor {
            let needsDarkMode: Bool
            if #available(iOS 13.0, *) {
                needsDarkMode = UITraitCollection.current.userInterfaceStyle == .dark || force
            } else {
                needsDarkMode = force
            }

            guard needsDarkMode else {
                return self
            }

            let components = cgColor.components
            let firstComponent = ((components?[0])! * 299)
            let secondComponent = ((components?[1])! * 587)
            let thirdComponent = ((components?[2])! * 114)
            let brightness = (firstComponent + secondComponent + thirdComponent) / 1000

            let neededDarkness = brightness - 0.5
            let color: UIColor
            if neededDarkness < 0 {
                color = modified(additionalBrightness: -neededDarkness)
            } else {
                color = self
            }

            return color
        }
    }
#endif
