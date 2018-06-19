//
//  UIView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension UIView {

    public func setBorder(color: UIColor, width: CGFloat = UIScreen.oneDevicePixel, radius: CGFloat = 0) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius
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

}
