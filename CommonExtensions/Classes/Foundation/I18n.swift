//
//  I18n.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

import Foundation

extension String {
    /**
     Returns a localized string

     :returns: The localized string
     */
    public var localized: String {
        NSLocalizedString(self, comment: "")
    }

    /**
     Returns an uppercased localized string

     :returns: The localized string
     */
    public var localizedUppercase: String {
        localized.uppercased(with: Locale.current)
    }

    /**
     Returns a localized string using a replacement argument

     :returns: The localized string
     */
    public func localizedWithArg(_ arg: String?) -> String {
        String(format: localized, arg ?? "")
    }

    /**
     Returns a localized string using multiple replacement arguments

     :param: args   A list of arguments to be used as replacements in the localized string

     :returns: The localized string
     */
    public func localizedWithArgs(_ args: [String?]) -> String {
        String(format: localized, arguments: args.map { $0 ?? "" })
    }

    /**
     Returns the language name corresponding to the ISO code, in the current language

     :returns: The language name
     */
    public var languageNameFromISOCode: String? {
        guard let currentLanguageCode = Locale.current.languageCode else { return nil }

        let locale = Locale(identifier: currentLanguageCode)
        return (locale as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: self)
    }

    /**
     Returns the language name corresponding to the ISO code, in its native language

     :returns: The native language name
     */
    public var nativeLanguageNameFromISOCode: String? {
        let locale = Locale(identifier: self)
        return (locale as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: self)
    }

    /**
     Returns the localized country name corresponding to the ISO code

     :returns: The localized country name
     */
    public var countryNameFromISOCode: String? {
        Locale.current.localizedString(forRegionCode: self)
    }
}
