//
//  Math.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

import Foundation

extension Int {
    public var degreesToRadians: Double { Double(self) * .pi / 180 }
}

extension FloatingPoint {
    public var degreesToRadians: Self { self * .pi / 180 }
    public var radiansToDegrees: Self { self * 180 / .pi }
}

extension Bool {
    public var intValue: Int {
        NSNumber(value: self).intValue
    }
}
