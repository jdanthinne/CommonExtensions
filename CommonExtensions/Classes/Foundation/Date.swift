//
//  Date.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension Date {
    
    public static var now: Int {
        return Int(Date().timeIntervalSince1970)
    }
    
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
