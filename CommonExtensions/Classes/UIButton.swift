//
//  UIButton.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension UIButton {
    
    public func setTitleWithoutAnimation(title: String?) {
        UIView.setAnimationsEnabled(false)
        setTitle(title, for: .normal)
        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }
    
}
