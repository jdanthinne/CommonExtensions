//
//  UIEdgeInset.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 6/03/18.
//

import UIKit

extension UIEdgeInsets {
    mutating func add(_ insets: UIEdgeInsets?) {
        guard let insets = insets else { return }

        top += insets.top
        left += insets.left
        bottom += insets.bottom
        right += insets.right
    }
}
