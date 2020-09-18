//
//  SelfConfiguringView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 18/10/2019.
//

import Foundation

public protocol SelfConfiguringView {
    associatedtype ViewModel

    static var reuseIdentifier: String { get }
    func configure(with model: ViewModel)
}

extension SelfConfiguringView {
    public func configure(with model: ViewModel) {
        // No config needed by default
    }
}
