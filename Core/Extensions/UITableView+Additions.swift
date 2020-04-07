//
//  UITableView+Additions.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

public protocol TableViewCellType {
    static var identifier: String { get }
}

public extension TableViewCellType where Self: UITableViewCell {
    static var identifier: String { return String(describing: self.self) }
}

public extension TableViewCellType where Self: UITableViewHeaderFooterView {
    static var identifier: String { return String(describing: self.self) }
}

extension UITableViewCell: TableViewCellType {}

extension UITableViewHeaderFooterView: TableViewCellType {}

public extension UITableView {

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

    func register<Cell>(
        cell: Cell.Type,
        forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
        ) where Cell: UITableViewHeaderFooterView {
        register(cell, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }

    func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewCell {
        return dequeueReusableCell(withIdentifier: reusableCell.identifier) as? Cell
    }

    func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewHeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: reusableCell.identifier) as? Cell
    }
}
