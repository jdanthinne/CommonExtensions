//
//  UICollectionView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

#if os(iOS)
    import UIKit

    extension UICollectionView {
        public func register(cellWithReuseIdentifiers names: [String]) {
            names.forEach { self.register(UINib(nibName: $0, bundle: nil),
                                          forCellWithReuseIdentifier: $0) }
        }

        public func register(supplementaryViewOfKind kind: String, withReuseIdentifiers names: [String]) {
            names.forEach {
                self.register(UINib(nibName: $0, bundle: nil),
                              forSupplementaryViewOfKind: kind,
                              withReuseIdentifier: $0)
            }
        }

        public func configure<T: SelfConfiguringView>(_ cellType: T.Type, with model: T.ViewModel, for indexPath: IndexPath) -> T {
            guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError("Unable to dequeue \(cellType)")
            }

            cell.configure(with: model)
            return cell
        }

        public func configure<T: SelfConfiguringView>(_ cellType: T.Type, ofKind kind: String, with model: T.ViewModel, for indexPath: IndexPath) -> T {
            guard let view = dequeueReusableSupplementaryView(ofKind: kind,
                                                              withReuseIdentifier: cellType.reuseIdentifier,
                                                              for: indexPath) as? T
            else {
                fatalError("Unable to dequeue \(cellType)")
            }

            view.configure(with: model)
            return view
        }

        public func deselectSelectedItems(animated: Bool = true) {
            indexPathsForSelectedItems?.forEach { deselectItem(at: $0, animated: animated) }
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

    // Source: https://stackoverflow.com/a/51389412/3675395
    public class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
        override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let attributes = super.layoutAttributesForElements(in: rect)?
                .map { $0.copy() } as? [UICollectionViewLayoutAttributes]

            attributes?
                .filter { $0.representedElementCategory == .cell }
                .reduce([:]) {
                    $0.merging([ceil($1.center.y): [$1]]) {
                        $0 + $1
                    }
                }
                .values.forEach { line in
                    let maxHeightY = line.max {
                        $0.frame.size.height < $1.frame.size.height
                    }?.frame.origin.y

                    line.forEach {
                        $0.frame = $0.frame.offsetBy(
                            dx: 0,
                            dy: (maxHeightY ?? $0.frame.origin.y) - $0.frame.origin.y
                        )
                    }
                }

            return attributes
        }
    }
#endif
