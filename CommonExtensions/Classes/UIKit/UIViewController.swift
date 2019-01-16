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

@objc public protocol KeyboardChangesDelegate {
    @objc optional var keyboardChangesScrollView: UIScrollView { get }
    @objc optional var keyboardChangesInsetsWhenShown: UIEdgeInsets { get }
    @objc optional var keyboardChangesInsetsWhenHidden: UIEdgeInsets { get }
    @objc optional func keyboardChangesAdditionnalInsetsWhenShown() -> UIEdgeInsets
    @objc optional func keyboardChangesAdditionnalInsetsWhenHidden() -> UIEdgeInsets
    @objc optional func keyboardChangesDidChangeFrame(keyboardHeight: CGFloat)
    @objc optional func keyboardChangesDidHide()
}

extension UIViewController {
    
    public func add(_ child: UIViewController, to view: UIView? = nil, stackViewPosition: Int? = nil) {
        addChild(child)
        let containerView: UIView = view ?? self.view
        if let stackView = view as? UIStackView {
            if let position = stackViewPosition {
                stackView.insertArrangedSubview(child.view, at: position)
            } else {
                stackView.addArrangedSubview(child.view)
            }
        } else {
            containerView.addSubview(child.view)
        }
        child.didMove(toParent: self)
    }
    
    public func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    public func handleKeyboardChanges() {
        if self is KeyboardChangesDelegate {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillChangeFrame(_:)),
                                                   name: UIResponder.keyboardWillChangeFrameNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillBeHidden(_:)),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        }
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        if let delegate = self as? KeyboardChangesDelegate, let userInfo = notification.userInfo {
            if let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                if let scrollView = delegate.keyboardChangesScrollView {
                    var insets = UIEdgeInsets(top: (delegate.keyboardChangesInsetsWhenShown?.top ?? 0) + scrollView.contentInset.top,
                                              left: (delegate.keyboardChangesInsetsWhenShown?.left ?? 0),
                                              bottom: (delegate.keyboardChangesInsetsWhenShown?.bottom ?? 0) + keyboardHeight - (tabBarController?.tabBar.frame.size.height ?? 0),
                                              right: (delegate.keyboardChangesInsetsWhenShown?.right ?? 0))
                    
                    insets.add(delegate.keyboardChangesAdditionnalInsetsWhenShown?())
                    
                    scrollView.contentInset = insets
                    scrollView.scrollIndicatorInsets = insets
                }
                
                delegate.keyboardChangesDidChangeFrame?(keyboardHeight: keyboardHeight)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(_ notification: Notification) {
        if let delegate = self as? KeyboardChangesDelegate {
            if let scrollView = delegate.keyboardChangesScrollView {
                var insets = UIEdgeInsets(top: (delegate.keyboardChangesInsetsWhenHidden?.top ?? 0) + scrollView.contentInset.top,
                                          left: (delegate.keyboardChangesInsetsWhenHidden?.left ?? 0),
                                          bottom: (delegate.keyboardChangesInsetsWhenHidden?.bottom ?? 0),
                                          right: (delegate.keyboardChangesInsetsWhenHidden?.right ?? 0))
                
                insets.add(delegate.keyboardChangesAdditionnalInsetsWhenHidden?())
                
                scrollView.contentInset = insets
                scrollView.scrollIndicatorInsets = insets
            }
            
            delegate.keyboardChangesDidHide?()
        }
    }
    
}
