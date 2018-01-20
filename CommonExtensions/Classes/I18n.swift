//
//  I18n.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension String {
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    public var localizedUppercase: String {
        return self.localized.uppercased(with: Locale.current)
    }
    
    public func localizedWithArg(_ arg: String?) -> String {
        return String(format: localized, arg ?? "")
    }
    
    public func localizedWithArgs(_ args: [String]) -> String {
        return String(format: localized, arguments: args)
    }
    
}
