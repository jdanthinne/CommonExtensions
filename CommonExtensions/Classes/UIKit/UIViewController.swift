//
//  UIViewController.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

#if os(iOS)
    import UIKit

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
                        let topInset: CGFloat = (delegate.keyboardChangesInsetsWhenShown?.top ?? 0) + scrollView.contentInset.top
                        let bottomInset: CGFloat = (delegate.keyboardChangesInsetsWhenShown?.bottom ?? 0) + keyboardHeight - (tabBarController?.tabBar.frame.size.height ?? 0)
                        let leftInset: CGFloat = delegate.keyboardChangesInsetsWhenShown?.left ?? 0
                        let rightInset: CGFloat = delegate.keyboardChangesInsetsWhenShown?.right ?? 0

                        var insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)

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
                    let topInset: CGFloat = (delegate.keyboardChangesInsetsWhenHidden?.top ?? 0) + scrollView.contentInset.top
                    let bottomInset: CGFloat = delegate.keyboardChangesInsetsWhenHidden?.bottom ?? 0
                    let leftInset: CGFloat = delegate.keyboardChangesInsetsWhenHidden?.left ?? 0
                    let rightInset: CGFloat = delegate.keyboardChangesInsetsWhenHidden?.right ?? 0

                    var insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)

                    insets.add(delegate.keyboardChangesAdditionnalInsetsWhenHidden?())

                    scrollView.contentInset = insets
                    scrollView.scrollIndicatorInsets = insets
                }

                delegate.keyboardChangesDidHide?()
            }
        }
    }
#endif
