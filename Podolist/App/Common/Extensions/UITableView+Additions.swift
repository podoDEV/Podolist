//
//  UITableView+Additions.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

protocol TableViewCellType {
    static var identifier: String { get }
}

extension UITableViewCell: TableViewCellType {
    static var identifier: String { return String(describing: self.self) }
}

extension UITableView {

    func registerNib<Cell>(
        cell: Cell.Type,
        forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
        ) where Cell: UITableViewCell {
        register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }

    func register<Cell>(
        cell: Cell.Type,
        forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
        ) where Cell: UITableViewCell {
        register(cell, forCellReuseIdentifier: reuseIdentifier)
    }

    func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewCell {
        return dequeueReusableCell(withIdentifier: reusableCell.identifier) as? Cell
    }
}
