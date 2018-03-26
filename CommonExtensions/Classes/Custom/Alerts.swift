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
                           message: String?,
                           messageIsLocalized: Bool = false,
                           withMessageArgument messageArgument: String = "",
                           okButton: String = "OK",
                           confirm: (() -> Void)?) -> UIAlertController {
        
        let title = titleIsLocalized ? alertTitle : alertTitle.localized
        
        var finalMessage: String?
        if let message = message {
            if messageIsLocalized {
                finalMessage = message
            }
            else {
                finalMessage = messageArgument != "" ? message.localizedWithArg(messageArgument) : message.localized
            }
        }
        
        let alert = UIAlertController(title: title, message: finalMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: okButton.localized, style: .default, handler: { (action) -> Void in
            if let confirm = confirm {
                confirm()
            }
        }))
        
        return alert
    }
    
    public class func confirmAlert(title alertTitle: String,
                            withTitleArgument titleArgument: String = "",
                            message: String?,
                            messageIsLocalized: Bool = false,
                            withMessageArgument messageArgument: String = "",
                            button: String,
                            withButtonArgument buttonArgument: String = "",
                            buttonIsDestructive: Bool = false,
                            cancelButton: String,
                            preferredStyle: UIAlertControllerStyle = .alert,
                            confirm: (() -> Void)?,
                            cancel: (() -> Void)?) -> UIAlertController {
        
        let finalTitle = titleArgument != "" ? alertTitle.localizedWithArg(titleArgument) : alertTitle.localized
        
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
        alert.addAction(UIAlertAction(title: cancelButton.localized, style: .cancel, handler: { (action) -> Void in
            if let cancel = cancel {
                cancel()
            }
        }))
        alert.addAction(UIAlertAction(title: buttonTitle, style: buttonIsDestructive ? .destructive : .default, handler: { (action) -> Void in
            if let confirm = confirm {
                confirm()
            }
        }))
        
        return alert
    }
    
    public class func passwordAlert(title alertTitle: String, message: String?, confirm: ((_ value: String) -> Void)?, cancel: (() -> Void)?) -> UIAlertController {
        var finalMessage: String?
        if let message = message {
            finalMessage = message.localized
        }
        let alert = UIAlertController(title: alertTitle.localized, message: finalMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { textField in
            textField.placeholder = "ACCESS_CODE".localized
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "ACTION_CANCEL".localized, style: .cancel, handler: { (action) -> Void in
            if let cancel = cancel {
                cancel()
            }
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            if let confirm = confirm, let textFields = alert.textFields, let textField = textFields.first {
                confirm(textField.text!)
            }
        }))
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
    
    public func present(in viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            viewController.present(self, animated: animated, completion: completion)
            self.view.tintColor = viewController.view.tintColor
        }
    }
    
    public func present() {
        if let vc = UIApplication.topViewController() {
            self.present(in: vc)
        }
    }
    
}
