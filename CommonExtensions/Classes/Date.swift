//
//  Date.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension Date {
    
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
