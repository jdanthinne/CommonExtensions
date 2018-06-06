//
//  UIStackView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 6/06/18.
//

extension UIStackView {
    
    public func removeAllSubviews() {
        for subview in self.arrangedSubviews {
            self.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
}
