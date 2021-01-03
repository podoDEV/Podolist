
import UIKit
import Services

enum TodolistSectionModel {
  case todos(items: [TodolistSectionItem])
}
extension TodolistSectionModel {
  typealias Item = TodolistSectionItem

  var items: [Item] {
    get {
      switch self {
      case let .todos(items): return items
      }
    } set {
      switch self {
      case .todos: self = .todos(items: newValue)
      }
    }
  }
}

enum TodolistSectionItem {
  case header(TodolistHeaderCellModel)
  case todo(TodolistRowCellModel)
}

struct TodolistHeaderCellModel {
  var title: String
  var color: UIColor
  var rows: [Todo]
  var editable: Bool
  var visible: Bool

  init(
    title: String,
    color: UIColor,
    rows: [Todo],
    editable: Bool = false,
    visible: Bool = true
  ) {
    self.title = title
    self.color = color
    self.rows = rows
    self.editable = editable
    self.visible = visible
  }
}

struct TodolistRowCellModel {

}
