
import UIKit

public extension String {
  var uiImage: UIImage? {
    return UIImage(named: self, in: Bundle(identifier: "com.podo.podolist.resources"), compatibleWith: .none)
  }
}
