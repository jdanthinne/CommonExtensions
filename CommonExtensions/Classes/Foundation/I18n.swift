//
//  I18n.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension String {

    /**
     Return a localized string
     
     :returns: No return value
     */
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    public var localizedUppercase: String {
        return self.localized.uppercased(with: Locale.current)
    }
    
    public func localizedWithArg(_ arg: String?) -> String {
        return String(format: localized, arg ?? "")
    }
    
    /**
     Return a localized string with multiple arguments
     
     :param: args   A list of arguments to be used as replacement in the localized string
     
     :returns: A localized string
     */
    public func localizedWithArgs(_ args: [String]) -> String {
        return String(format: localized, arguments: args)
    }
    
    public var isoToLanguageName: String {
        let locale = Locale(identifier: Locale.current.languageCode!)
        return (locale as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: self)!
    }
    
    public var isoToNativeLanguageName: String {
        let locale = Locale(identifier: self)
        return (locale as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: self)!
    }
    
}
