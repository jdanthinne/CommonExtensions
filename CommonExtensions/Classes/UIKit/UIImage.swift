//
//  UIImage.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 11/03/2019.
//

import UIKit

extension UIImage {
    
    public convenience init?(gradient: [UIColor], width: CGFloat = 1, height: CGFloat, radius: CGFloat = 0) {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        let locations: [CGFloat] = [0, 1]
        let colors: CFArray = gradient.map({ $0.cgColor }) as CFArray
        
        guard let context = UIGraphicsGetCurrentContext(),
            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                      colors: colors,
                                      locations: locations)
            else { return nil }
        
        context.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath)
        context.clip()
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: height), options: [])
        context.closePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
    
}
