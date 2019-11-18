//
//  SelfConfiguringCell.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 18/10/2019.
//

import Foundation

public protocol SelfConfiguringCell {
    associatedtype CellModel

    static var reuseIdentifier: String { get }
    func configure(with model: CellModel)
}

extension SelfConfiguringCell {
    public func configure(with model: CellModel) {
        // No config needed by default
    }
}

public protocol SelfConfiguringHeaderFooterView {
    associatedtype ViewModel

    static var reuseIdentifier: String { get }
    func configure(with model: ViewModel)
}

extension SelfConfiguringHeaderFooterView {
    public func configure(with model: ViewModel) {
        // No config needed by default
    }
}
