//
//  UIButton.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

import UIKit

extension UIButton {
    public func setTitleWithoutAnimation(title: String?) {
        UIView.setAnimationsEnabled(false)
        setTitle(title, for: .normal)
        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }

    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))

        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        setBackgroundImage(colorImage, for: state)
    }
}
