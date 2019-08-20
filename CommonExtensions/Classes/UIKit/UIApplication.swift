//
//  UIApplication.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 14/08/2019.
//

import UIKit

extension UIApplication {
    public class func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}

