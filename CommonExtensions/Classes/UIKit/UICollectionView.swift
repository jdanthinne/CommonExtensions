//
//  UICollectionView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension UICollectionView {
    
    public func register(cellWithReuseIdentifiers names: [String]) {
        names.forEach({ self.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0) })
    }
    
    public func register(supplementaryViewOfKind kind: String, withReuseIdentifiers names: [String]) {
        names.forEach({ self.register(UINib(nibName: $0, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: $0) })
    }
    
    public func deselectSelectedItems(animated: Bool = true) {
        indexPathsForSelectedItems?.forEach({ deselectItem(at: $0, animated: animated) })
    }
    
}
