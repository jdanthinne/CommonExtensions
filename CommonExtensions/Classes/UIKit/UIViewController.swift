//
//  UIViewController.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension UIApplication {

    public class func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController

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

@objc protocol KeyboardChangesDelegate {
    var keyboardChangesScrollView: UIScrollView { get }
    @objc optional var keyboardChangesInsetsWhenShown: UIEdgeInsets { get }
    @objc optional var keyboardChangesInsetsWhenHidden: UIEdgeInsets { get }
    @objc optional func keyboardChangesAdditionnalInsetsWhenShown() -> UIEdgeInsets
    @objc optional func keyboardChangesAdditionnalInsetsWhenHidden() -> UIEdgeInsets
    @objc optional func keyboardChangesDidChangeFrame()
    @objc optional func keyboardChangesDidHide()
}

extension UIViewController {
    
    func handleKeyboardChanges() {
        if self is KeyboardChangesDelegate {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: .UIKeyboardWillHide, object: nil)
        }
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        if let delegate = self as? KeyboardChangesDelegate, let userInfo = notification.userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                var insets = UIEdgeInsets(top: (delegate.keyboardChangesInsetsWhenShown?.top ?? 0) + delegate.keyboardChangesScrollView.contentInset.top,
                                          left: (delegate.keyboardChangesInsetsWhenShown?.left ?? 0),
                                          bottom: (delegate.keyboardChangesInsetsWhenShown?.bottom ?? 0) + keyboardHeight,
                                          right: (delegate.keyboardChangesInsetsWhenShown?.right ?? 0))
                
                insets.add(delegate.keyboardChangesAdditionnalInsetsWhenShown?())
                
                delegate.keyboardChangesScrollView.contentInset = insets
                delegate.keyboardChangesScrollView.scrollIndicatorInsets = insets
                
                delegate.keyboardChangesDidChangeFrame?()
            }
        }
    }
    
    @objc func keyboardWillBeHidden(_ notification: Notification) {
        if let delegate = self as? KeyboardChangesDelegate {
            var insets = UIEdgeInsets(top: (delegate.keyboardChangesInsetsWhenHidden?.top ?? 0) + delegate.keyboardChangesScrollView.contentInset.top,
                                      left: (delegate.keyboardChangesInsetsWhenHidden?.left ?? 0),
                                      bottom: (delegate.keyboardChangesInsetsWhenHidden?.bottom ?? 0),
                                      right: (delegate.keyboardChangesInsetsWhenHidden?.right ?? 0))
            
            insets.add(delegate.keyboardChangesAdditionnalInsetsWhenHidden?())
            
            delegate.keyboardChangesScrollView.contentInset = insets
            delegate.keyboardChangesScrollView.scrollIndicatorInsets = insets
            
            delegate.keyboardChangesDidHide?()
        }
    }
    
}
