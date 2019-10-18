//
//  UIScreen.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

#if os(iOS)
    import UIKit

    extension UIScreen {
        public static let oneDevicePixel = 1 / UIScreen.main.scale
    }
#endif
