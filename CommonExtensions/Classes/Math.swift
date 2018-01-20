//
//  Math.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension Int {
    
    public var degreesToRadians: Double { return Double(self) * .pi / 180 }
    
}

extension FloatingPoint {
    
    public var degreesToRadians: Self { return self * .pi / 180 }
    public var radiansToDegrees: Self { return self * 180 / .pi }
    
}
