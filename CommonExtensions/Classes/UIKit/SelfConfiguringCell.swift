//
//  SelfConfiguringCell.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 18/10/2019.
//

import Foundation

protocol SelfConfiguringCell {
    associatedtype CellModel

    static var reuseIdentifier: String { get }
    func configure(with model: CellModel)
}

extension SelfConfiguringCell {
    func configure(with model: CellModel) {
        // No config needed by default
    }
}
