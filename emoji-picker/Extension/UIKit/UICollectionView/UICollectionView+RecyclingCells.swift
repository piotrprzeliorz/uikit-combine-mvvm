//
//  UICollectionView+RecyclingCells.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

extension UICollectionView {

    func register<Cell: UICollectionViewCell>(_ cell: Cell.Type = Cell.self) {
        let cellName = String(describing: cell)
        register(cell.self, forCellWithReuseIdentifier: cellName)
    }

    func registerHeader<View: UICollectionReusableView>(_ type: View.Type) {
        register(type, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: type))
    }


    func dequeue<Cell: UICollectionViewCell>(cell: Cell.Type = Cell.self, for indexPath: IndexPath) -> Cell {
        let cellName = String(describing: cell)
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? Cell else {
            fatalError("Failed to dequeue a cell with identifier \(cellName)")
        }

        return cell
    }

    func dequeueHeaderView<View>(for indexPath: IndexPath) -> View where View: UICollectionReusableView {
        let viewName = String(describing: View.self)
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: viewName, for: indexPath) as? View else {
            fatalError("Could not dequeue header with identifier: \(View.self)")
        }

        return view
    }
}
