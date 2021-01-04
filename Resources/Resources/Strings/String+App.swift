
import Foundation

public extension String {
  init(urlOfResourceFile: String) {
    if let path = Bundle(identifier: "com.podo.podolist.resources")!.path(forResource: urlOfResourceFile, ofType: nil),
      let text = try? String(contentsOfFile: path, encoding: .utf8) {
      self = text
    } else {
      self = ""
    }
  }

  var localized: String {
    NSLocalizedString(
      self,
      tableName: nil,
      bundle: Bundle(identifier: "com.podo.podolist.resources")!,
      value: "",
      comment: ""
    )
  }
}
