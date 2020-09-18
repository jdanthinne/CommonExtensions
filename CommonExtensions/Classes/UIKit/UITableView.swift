//
//  UITableView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

#if os(iOS)
    import UIKit

    extension UITableView {
        public func register(cellsWithReuseIdentifiers names: [String]) {
            names.forEach { self.register(UINib(nibName: $0, bundle: nil),
                                          forCellReuseIdentifier: $0) }
        }

        public func register(headerFooterWithReuseIdentifiers names: [String]) {
            names.forEach { self.register(UINib(nibName: $0, bundle: nil),
                                          forHeaderFooterViewReuseIdentifier: $0) }
        }

        public func configure<T: SelfConfiguringView>(_ cellType: T.Type, with model: T.ViewModel, for indexPath: IndexPath) -> T {
            guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier,
                                                 for: indexPath) as? T else {
                fatalError("Unable to dequeue \(cellType)")
            }

            cell.configure(with: model)
            return cell
        }

        public func configure<T: SelfConfiguringView>(_ viewType: T.Type, with model: T.ViewModel) -> T {
            guard let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T else {
                fatalError("Unable to dequeue \(viewType)")
            }

            view.configure(with: model)
            return view
        }

        public func deselectSelectedRows() {
            indexPathsForSelectedRows?.forEach { self.deselectRow(at: $0, animated: true) }
        }

        public func reloadData(withoutScroll scroll: Bool = false) {
            if scroll {
                reloadData()
            } else {
                let offset = contentOffset
                reloadData()
                layoutIfNeeded()
                contentOffset = offset
            }
        }
    }

    extension IndexPath {
        public func isLastRowOfSection(_ section: Int? = nil, in tableView: UITableView) -> Bool {
            let section = section ?? self.section
            return row + 1 == tableView.numberOfRows(inSection: section)
        }

        public func isLastRowOfTableView(_ tableView: UITableView) -> Bool {
            section == tableView.numberOfSections - 1 && isLastRowOfSection(in: tableView)
        }
    }
#endif
