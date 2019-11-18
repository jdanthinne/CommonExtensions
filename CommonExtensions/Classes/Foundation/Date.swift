//
//  Date.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

import Foundation

extension Date {
    public static var now: Int {
        Int(Date().timeIntervalSince1970)
    }

    public var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
