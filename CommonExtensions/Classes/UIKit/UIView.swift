//
//  UIView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension UIView {
    
    public func setBorder(color: UIColor, width: CGFloat = 1) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    public func addRoundedBorder(color: UIColor, cornerRadius: CGFloat, lineDashPattern: [NSNumber]? = nil) {
        let rect = CGRect(x: 0.5, y: 0.5, width: self.bounds.width - 1, height: self.bounds.height - 1)
        let borderPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = borderPath
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineWidth = 1
        borderLayer.fillColor = nil
        borderLayer.frame = self.bounds
        borderLayer.lineDashPattern = lineDashPattern
        
        self.layer.addSublayer(borderLayer)
    }
    
}
