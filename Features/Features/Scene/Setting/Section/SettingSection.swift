
enum SettingSectionModel {
  case info(items: [SettingSectionItem])
}

extension SettingSectionModel {
  typealias Item = SettingSectionItem

  var items: [Item] {
    get {
      switch self {
      case let .info(items): return items
      }
    } set {
      switch self {
      case .info: self = .info(items: newValue)
      }
    }
  }
}

enum SettingSectionItem {
  case account(SettingAccountRow)
  case about(SettingRow)
  case license(SettingRow)
  case feedback(SettingRow)
  case logout(SettingRow)
}

enum SettingRowType: String {
  case account
  case about
  case license
  case feedback
  case logout
}

struct SettingRow {
  var type: SettingRowType
  var title: String
}

struct SettingAccountRow {
  var type: SettingRowType
  var title: String

  var name: String
  var email: String?
  var imageUrl: String?
}
