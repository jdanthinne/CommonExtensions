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
        
        self.top += insets.top
        self.left += insets.left
        self.bottom += insets.bottom
        self.right += insets.right
    }
    
}
