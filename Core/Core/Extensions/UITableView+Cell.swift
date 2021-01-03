
import UIKit

public extension UITableView {
  func register<Cell>(
    cell: Cell.Type,
    forCellReuseIdentifier reuseIdentifier: String = Cell.reuseIdentifier
  ) where Cell: UITableViewCell {
    register(cell, forCellReuseIdentifier: reuseIdentifier)
  }

  func register<Cell>(
    cell: Cell.Type,
    forCellReuseIdentifier reuseIdentifier: String = Cell.reuseIdentifier
  ) where Cell: UITableViewHeaderFooterView {
    register(cell, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
  }

  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewCell {
    return dequeueReusableCell(withIdentifier: reusableCell.reuseIdentifier) as? Cell
  }

  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewHeaderFooterView {
    return dequeueReusableHeaderFooterView(withIdentifier: reusableCell.reuseIdentifier) as? Cell
  }
}

public protocol Reusable {}
public extension Reusable where Self: UIView {
  static var reuseIdentifier: String {
    return String(describing: self.self)
  }
}

extension UITableViewHeaderFooterView: Reusable {}
extension UITableViewCell: Reusable {}
//
//
//import UIKit
//
//public protocol TableViewCellType {
//  static var identifier: String { get }
//}
//
//public extension TableViewCellType where Self: UITableViewCell {
//  static var identifier: String { return String(describing: self.self) }
//}
//
//public extension TableViewCellType where Self: UITableViewHeaderFooterView {
//  static var identifier: String { return String(describing: self.self) }
//}
//
//extension UITableViewCell: TableViewCellType {}
//
//extension UITableViewHeaderFooterView: TableViewCellType {}
//
//public extension UITableView {
//
//  func registerNib<Cell>(
//    cell: Cell.Type,
//    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
//  ) where Cell: UITableViewCell {
//    register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
//  }
//
//  func register<Cell>(
//    cell: Cell.Type,
//    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
//  ) where Cell: UITableViewCell {
//    register(cell, forCellReuseIdentifier: reuseIdentifier)
//  }
//
//  func register<Cell>(
//    cell: Cell.Type,
//    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
//  ) where Cell: UITableViewHeaderFooterView {
//    register(cell, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
//  }
//
//  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewCell {
//    return dequeueReusableCell(withIdentifier: reusableCell.identifier) as? Cell
//  }
//
//  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewHeaderFooterView {
//    return dequeueReusableHeaderFooterView(withIdentifier: reusableCell.identifier) as? Cell
//  }
//}
