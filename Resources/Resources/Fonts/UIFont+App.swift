
import UIKit

public enum AppFont: String, CaseIterable {
  case notoSansBold = "NotoSans-Bold"
  case notoSansLight = "NotoSans-Light"
  case notoSansMedium = "NotoSans-Medium"
  case notoSansRegular = "NotoSans-Regular"
}

public extension UIFont {
  class func preferredFont(type: AppFont, size: CGFloat) -> UIFont {
    return UIFont(name: type.rawValue, size: size)!
  }
}

public extension UIFont {
  class func loadAllFonts(identifier: String = "com.podo.podolist.resources") {
    AppFont.allCases.forEach {
      registerFont(filename: $0.rawValue.appending(".ttf"), identifier: identifier)
    }
  }

  static func registerFont(filename: String, identifier: String) {
    if let frameworkBundle = Bundle(identifier: identifier) {
      let filePath = frameworkBundle.path(forResource: filename, ofType: nil)!
      let fontData = NSData(contentsOfFile: filePath)!
      let dataProvider = CGDataProvider(data: fontData)!
      let fontRef = CGFont(dataProvider)!
      var errorRef: Unmanaged<CFError>? = nil

      if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
        print("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
      }
    }
    else {
      print("Failed to register font - bundle identifier invalid.")
    }
  }
}
