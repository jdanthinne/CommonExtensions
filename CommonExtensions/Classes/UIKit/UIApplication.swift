//
//  UIApplication.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 14/08/2019.
//

import UIKit

extension UIApplication {
    static public var globalTintColor: UIColor? {
        return shared.keyWindow?.tintColor
    }
}
