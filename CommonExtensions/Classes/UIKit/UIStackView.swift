//
//  UIStackView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 6/06/18.
//

#if os(iOS)
    import UIKit

    extension UIStackView {
        public func removeAllSubviews() {
            for subview in arrangedSubviews {
                removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
        }
    }
#endif
