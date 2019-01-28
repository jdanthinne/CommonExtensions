//
//  UIView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

import UIKit

extension UIView {

    public func setBorder(color: UIColor, width: CGFloat = UIScreen.oneDevicePixel, radius: CGFloat? = nil) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        if let radius = radius {
            layer.cornerRadius = radius
        }
    }

    public func addRoundedBorder(color: UIColor,
                                 width: CGFloat = 1,
                                 cornerRadius: CGFloat,
                                 lineDashPattern: [NSNumber]? = nil) {

        let rect = CGRect(x: 0.5, y: 0.5, width: self.bounds.width - 1, height: self.bounds.height - 1)
        let borderPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath

        let borderLayer = CAShapeLayer()
        borderLayer.path = borderPath
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineWidth = width
        borderLayer.fillColor = nil
        borderLayer.frame = self.bounds
        borderLayer.lineDashPattern = lineDashPattern

        self.layer.addSublayer(borderLayer)
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    public func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    public var safeAreaTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }
    
    public var safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }

}
