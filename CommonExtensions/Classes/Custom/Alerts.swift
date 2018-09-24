//
//  Alerts.swift
//  CommonClasses
//
//  Created by Jérôme Danthinne on 26/03/18.
//

import UIKit

public class Alerts {
    
    public class func simpleAlert(title alertTitle: String,
                           titleIsLocalized: Bool = false,
                           message: String? = nil,
                           messageIsLocalized: Bool = false,
                           withMessageArgument messageArgument: String = "",
                           attributedMessage: NSMutableAttributedString? = nil,
                           okButton: String = "OK",
                           style: UIAlertController.Style = .alert,
                           popoverSourceView: UIView? = nil,
                           popoverBarButtonItem: UIBarButtonItem? = nil,
                           popoverArrowDirections: UIPopoverArrowDirection = [.up],
                           confirm: (() -> Void)? = nil) -> UIAlertController {
        
        return builder(title: alertTitle,
                       titleIsLocalized: titleIsLocalized,
                       message: message,
                       messageIsLocalized: messageIsLocalized,
                       withMessageArgument: messageArgument,
                       attributedMessage: attributedMessage,
                       button: okButton,
                       preferredStyle: style,
                       popoverSourceView: popoverSourceView,
                       popoverBarButtonItem: popoverBarButtonItem,
                       popoverArrowDirections: popoverArrowDirections,
                       confirm: confirm)
    }
    
    public class func confirmAlert(title alertTitle: String? = nil,
                                   titleIsLocalized: Bool = false,
                                   withTitleArgument titleArgument: String = "",
                                   message: String? = nil,
                                   messageIsLocalized: Bool = false,
                                   withMessageArgument messageArgument: String = "",
                                   attributedMessage: NSMutableAttributedString? = nil,
                                   button: String,
                                   withButtonArgument buttonArgument: String = "",
                                   buttonIsDestructive: Bool = false,
                                   cancelButton: String? = nil,
                                   preferredStyle: UIAlertController.Style = .alert,
                                   popoverSourceView: UIView? = nil,
                                   popoverBarButtonItem: UIBarButtonItem? = nil,
                                   popoverArrowDirections: UIPopoverArrowDirection = [.up],
                                   confirm: (() -> Void)? = nil,
                                   cancel: (() -> Void)? = nil) -> UIAlertController {
        
        let cancelButton = cancelButton ?? "Cancel"
        
        return builder(title: alertTitle,
                       titleIsLocalized: titleIsLocalized,
                       withTitleArgument: titleArgument,
                       message: message,
                       messageIsLocalized: messageIsLocalized,
                       withMessageArgument: messageArgument,
                       attributedMessage: attributedMessage,
                       button: button,
                       withButtonArgument: buttonArgument,
                       buttonIsDestructive: buttonIsDestructive,
                       cancelButton: cancelButton,
                       preferredStyle: preferredStyle,
                       popoverSourceView: popoverSourceView,
                       popoverBarButtonItem: popoverBarButtonItem,
                       popoverArrowDirections: popoverArrowDirections,
                       confirm: confirm,
                       cancel: cancel)
    }
    
    private class func builder(title alertTitle: String? = nil,
                               titleIsLocalized: Bool = false,
                               withTitleArgument titleArgument: String = "",
                               message: String? = nil,
                               messageIsLocalized: Bool = false,
                               withMessageArgument messageArgument: String = "",
                               attributedMessage: NSMutableAttributedString? = nil,
                               button: String,
                               withButtonArgument buttonArgument: String = "",
                               buttonIsDestructive: Bool = false,
                               cancelButton: String? = nil,
                               preferredStyle: UIAlertController.Style = .alert,
                               popoverSourceView: UIView? = nil,
                               popoverBarButtonItem: UIBarButtonItem? = nil,
                               popoverArrowDirections: UIPopoverArrowDirection = [.up],
                               confirm: (() -> Void)? = nil,
                               cancel: (() -> Void)? = nil) -> UIAlertController {
        
        
        var finalTitle: String?
        if let alertTitle = alertTitle {
            if titleIsLocalized {
                finalTitle = alertTitle
            }
            else {
                finalTitle = titleArgument != "" ? alertTitle.localizedWithArg(titleArgument) : alertTitle.localized
            }
        }
        
        var finalMessage: String?
        if let message = message {
            if messageIsLocalized {
                finalMessage = message
            }
            else {
                finalMessage = messageArgument != "" ? message.localizedWithArg(messageArgument) : message.localized
            }
        }
        
        let buttonTitle = buttonArgument != "" ? button.localizedWithArg(buttonArgument) : button.localized
        
        let alert = UIAlertController(title: finalTitle, message: finalMessage, preferredStyle: preferredStyle)
        
        if let attributedMessage = attributedMessage {
            alert.setValue(attributedMessage, forKey: "attributedMessage")
        }
        
        if let sourceView = popoverSourceView {
            alert.popoverPresentationController?.sourceView = sourceView
            alert.popoverPresentationController?.sourceRect = CGRect(x: sourceView.frame.width / 2, y: 0, width: 1, height: 1)
        }
        else if let barButtonItem = popoverBarButtonItem {
            alert.popoverPresentationController?.barButtonItem = barButtonItem
        }
        alert.popoverPresentationController?.permittedArrowDirections = popoverArrowDirections
        
        if let cancelButton = cancelButton {
            alert.addAction(UIAlertAction(title: cancelButton.localized, style: .cancel, handler: { (action) -> Void in
                if let cancel = cancel {
                    cancel()
                }
            }))
        }
        
        let mainAction = UIAlertAction(title: buttonTitle, style: buttonIsDestructive ? .destructive : .default, handler: { (action) -> Void in
            if let confirm = confirm {
                confirm()
            }
        })
        alert.addAction(mainAction)
        alert.preferredAction = mainAction
        
        return alert
    }
    
    public class func passwordAlert(title: String, message: String, submit: @escaping (_ value: String) -> Void, cancel: (() -> Void)? = nil) -> UIAlertController {
        return promptAlert(title: title,
                           message: message,
                           placeholder: "ACCESS_CODE".localized,
                           validationRule: .nonEmpty,
                           textFieldConfiguration: { $0.isSecureTextEntry = true },
                           submit: { submit($0) },
                           cancel: cancel)
    }
    
    public class func promptAlert(title: String,
                                  message: String,
                                  attributedMessage: NSMutableAttributedString? = nil,
                                  placeholder: String?,
                                  actionTitle: String = "Ok",
                                  validationRule: String.ValidationRule,
                                  textFieldConfiguration: ((UITextField) -> Void)? = nil,
                                  submit: @escaping (_ value: String) -> Void,
                                  cancel: (() -> Void)? = nil) -> UIAlertController {
        
        class TextFieldObserver: NSObject, UITextFieldDelegate {
            let textFieldValueChanged: (UITextField) -> Void
            let textFieldShouldReturn: (UITextField) -> Bool
            
            init(textField: UITextField, valueChanged: @escaping (UITextField) -> Void, shouldReturn: @escaping (UITextField) -> Bool) {
                self.textFieldValueChanged = valueChanged
                self.textFieldShouldReturn = shouldReturn
                super.init()
                textField.delegate = self
                textField.addTarget(self, action: #selector(TextFieldObserver.textFieldValueChanged(sender:)), for: .editingChanged)
            }
            
            @objc func textFieldValueChanged(sender: UITextField) {
                textFieldValueChanged(sender)
            }
            
            // MARK: UITextFieldDelegate
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                return textFieldShouldReturn(textField)
            }
        }
        
        var textFieldObserver: TextFieldObserver?
        
        let alert = UIAlertController(title: title.localized, message: message.localized, preferredStyle: .alert)
        
        if let attributedMessage = attributedMessage {
            alert.setValue(attributedMessage, forKey: "attributedMessage")
        }
        
        let mainAction = UIAlertAction(title: actionTitle.localized, style: .default, handler: { _ in
            guard let title = alert.textFields?.first?.text else { return }
            if textFieldObserver != nil {
                textFieldObserver = nil
            }
            submit(title)
        })
        alert.addAction(mainAction)
        alert.preferredAction = mainAction
        
        alert.addAction(UIAlertAction(title: "ACTION_CANCEL".localized, style: .cancel, handler: { _ in
            if textFieldObserver != nil {
                textFieldObserver = nil
            }
            cancel?()
        }))
        
        alert.addTextField(configurationHandler: { textField in
            textFieldConfiguration?(textField)
            textField.placeholder = placeholder?.localized
            
            textFieldObserver = TextFieldObserver(textField: textField,
                                                  valueChanged: { textField in
                                                    mainAction.isEnabled = (textField.text ?? "").isValid(rule: validationRule)
            },
                                                  shouldReturn: { textField in
                                                    (textField.text ?? "").isValid(rule: validationRule)
            })
        })
        
        mainAction.isEnabled = (alert.textFields?.first?.text ?? "").isValid(rule: validationRule)
        
        return alert
    }
    
    public class func customView(_ view: UIView, title: String, titleIsLocalized: Bool = false,
                          preferredContentSize: CGSize, defaultActionTitle: String,
                          confirm: @escaping (_ action: UIAlertAction) -> Void) -> UIAlertController {
        let pickerVC = UIViewController()
        pickerVC.preferredContentSize = preferredContentSize
        pickerVC.view.addSubview(view)
        
        let title = titleIsLocalized ? title : title.localized
        
        let actionSheet = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        actionSheet.setValue(pickerVC, forKey: "contentViewController")
        actionSheet.addAction(UIAlertAction(title: defaultActionTitle.localized, style: .default, handler: confirm))
        actionSheet.addAction(UIAlertAction(title: "ACTION_CANCEL".localized, style: .cancel, handler: nil))
        
        return actionSheet
    }
    
}

extension UIAlertController {
    
    public func present(in viewController: UIViewController?, animated: Bool = true, tintColor: UIColor? = nil, topViewHasBeenTried: Bool = false, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            var vc = viewController
            if vc == nil, !topViewHasBeenTried {
                vc = UIApplication.topViewController()
            }
            
            if let presentingVC = vc {
                presentingVC.present(self, animated: animated, completion: completion)
                self.view.tintColor = tintColor ?? presentingVC.view.tintColor
            }
        }
    }
    
    public func present() {
        self.present(in: UIApplication.topViewController(), topViewHasBeenTried: true)
    }
    
}
