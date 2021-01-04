
import UIKit
import Services

enum TodolistSectionModel {
  case delayed(header: TodolistHeaderItem, items: [TodolistSectionItem])
  case todo(header: TodolistHeaderItem, items: [TodolistSectionItem])
}
extension TodolistSectionModel {
  typealias Item = TodolistSectionItem

  var items: [Item] {
    get {
      switch self {
      case let .delayed(_, items): return items
      case let .todo(_, items): return items
      }
    } set {
      switch self {
      case let .delayed(header, _): self = .delayed(header: header, items: newValue)
      case let .todo(header, _): self = .todo(header: header, items: newValue)
      }
    }
  }
}

enum TodolistHeaderItem {
  case header(TodolistHeaderCellModel)
}

enum TodolistSectionItem {
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
