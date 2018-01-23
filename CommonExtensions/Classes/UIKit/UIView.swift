//
//  UIView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension UIView {

    public func setBorder(color: UIColor, width: CGFloat = UIScreen.oneDevicePixel) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
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

}
