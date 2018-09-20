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
        names.forEach({
            self.register(UINib(nibName: $0, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: $0)
        })
    }

    public func deselectSelectedItems(animated: Bool = true) {
        indexPathsForSelectedItems?.forEach({ deselectItem(at: $0, animated: animated) })
    }

}

extension UICollectionViewCell {
    
    public func enableSelfSizing() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        /* Code below is needed to make the self-sizing cell work
         * when building for iOS 12 from Xcode 10.0.
         * Source: https://stackoverflow.com/a/52389062/3675395
         */
        if #available(iOS 12.0, *) {
            NSLayoutConstraint.activate([contentView.leftAnchor.constraint(equalTo: leftAnchor),
                                         contentView.rightAnchor.constraint(equalTo: rightAnchor),
                                         contentView.topAnchor.constraint(equalTo: topAnchor),
                                         contentView.bottomAnchor.constraint(equalTo: bottomAnchor)])
        }
    }
    
}
