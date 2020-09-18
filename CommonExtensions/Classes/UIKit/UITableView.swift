//
//  UITableView.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

#if os(iOS)
    import UIKit

    extension UITableView {
        public func register<T: SelfConfiguringCell>(selfConfiguringCells types: [T.Type]) {
            types.forEach {
                self.register(UINib(nibName: $0.reuseIdentifier, bundle: nil),
                              forCellReuseIdentifier: $0.reuseIdentifier)
            }
        }

        public func register<T: SelfConfiguringCell>(selfConfiguringHeaderFooter types: [T.Type]) {
            types.forEach { self.register(UINib(nibName: $0.reuseIdentifier, bundle: nil),
                                          forHeaderFooterViewReuseIdentifier: $0.reuseIdentifier) }
        }

        public func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with model: T.CellModel, for indexPath: IndexPath) -> T {
            guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError("Unable to dequeue \(cellType)")
            }

            cell.configure(with: model)
            return cell
        }

        public func configure<T: SelfConfiguringHeaderFooterView>(_ viewType: T.Type, with model: T.ViewModel) -> T {
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
