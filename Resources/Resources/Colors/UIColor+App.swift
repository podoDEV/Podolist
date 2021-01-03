
import UIKit

public extension UIColor {

  /// HEX: 4B45EA, RGB: 75,69,234
//  static let primary = UIColor(hex: "4B45EA", alpha: 1)
//  /// HEX: 546BE5, RGB: 84,107,229
//  static let secondary1 = UIColor(hex: "546BE5", alpha: 1)
//  /// HEX: 6971EA, RGB: 105,113,234
//  static let secondary2 = UIColor(hex: "6971EA", alpha: 1)
//  /// HEX: A9B4F2, RGB: 169,180,242
//  static let secondary3 = UIColor(hex: "A9B4F2", alpha: 1)
//  /// HEX: C3C6F7, RGB: 195,198,247
//  static let secondary4 = UIColor(hex: "C3C6F7", alpha: 1)
//  /// HEX: ECECFD, RGB: 236,236,253
//  static let secondary5 = UIColor(hex: "ECECFD", alpha: 1)
//  /// HEX: FAFBFF, RGB: 250,251,255
//  static let secondary6 = UIColor(hex: "FAFBFF", alpha: 1)
//  /// HEX: FFFFFF, RGB: 255,255,255
//  static let background1 = UIColor(hex: "FFFFFF", alpha: 1)
//  /// HEX: EAEAEA, RGB: 234,234,234
//  static let background2 = UIColor(hex: "EAEAEA", alpha: 1)
//  /// HEX: F2F2F2, RGB: 242,242,242
//  static let background3 = UIColor(hex: "F2F2F2", alpha: 1)
//  /// HEX: E6E6E9, RGB: 230,230,233
//  static let background4 = UIColor(hex: "E6E6E9", alpha: 1)
//  /// HEX: E9E9E9, RGB: 233,233,233
//  static let background5 = UIColor(hex: "E9E9E9", alpha: 1)
//  
//  /// HEX: 323232, RGB: 50,50,50
//  static let primaryText = UIColor(hex: "323232", alpha: 1)
//  /// HEX: 141414, RGB: 20,20,20
//  static let secondaryText1 = UIColor(hex: "141414", alpha: 1)
//  /// HEX: 707070, RGB: 112,112,112
//  static let secondaryText2 = UIColor(hex: "707070", alpha: 1)
//  /// HEX: 8E8E8E, RGB: 142,142,142
//  static let secondaryText3 = UIColor(hex: "8E8E8E", alpha: 1)
//  /// HEX: BBBBBB, RGB: 187,187,187
//  static let secondaryText4 = UIColor(hex: "BBBBBB", alpha: 1)
//  /// HEX: 716F77, RGB: 113,111,119
//  static let secondaryText5 = UIColor(hex: "716F77", alpha: 1)
//  /// HEX: 777777, RGB: 119,119,119
//  static let secondaryText6 = UIColor(hex: "777777", alpha: 1)
//
//  /// HEX: 4FD183, RGB: 79,209,131
//  static let properTextColor = UIColor(hex: "4FD183", alpha: 1)
//  static let properBackgroundColor = UIColor(hex: "4FD183", alpha: 0.1)
//  /// HEX: FF736E, RGB: 255,115,110
//  static let warningTextColor = UIColor(hex: "FF736E", alpha: 1)
//  static let warningBackgroundColor = UIColor(hex: "FF736E", alpha: 0.1)
  
  static let appColor1 = UIColor(hex: 0x9E30FE)
  static let appColor2 = UIColor(hex: 0xC32BFF) // 그라데이션 fill
  static let appColor3 = UIColor(hex: 0xD6ACFB) // 달력 날짜 선택
  static let appColor4 = UIColor(hex: 0xDEB9FF) // 투두리스트 완료

  static let gradationStart = UIColor(hex: 0x9E30FE)
  static let gradationEnd = UIColor(hex: 0xCD5EFF)

  static let kakaoLogin = UIColor(red: 255, green: 232, blue: 18, alpha: 1)
  
  static let delayedItems = UIColor(red: 208, green: 2, blue: 27, alpha: 1)
  static let normalItems = UIColor(red: 44, green: 44, blue: 44, alpha: 1)

  static let todoBackground1 = UIColor(hex: 0x9E30FE) // normal
  static let todoBackground2 = UIColor(hex: 0xDCC3FC) // completed

  static let priorityColor1 = UIColor(hex: 0xD0021B) // 매우 중요
  static let priorityColor2 = UIColor(hex: 0xF5A623) // 중요
  static let priorityColor3 = UIColor(hex: 0x7ED321) // 보통
  static let priorityColor4 = UIColor(hex: 0x50E3C2) // 여유
  static let priorityColor5 = UIColor(hex: 0x4A90E2) // 그냥

  static let backgroundColor1 = UIColor(hex: 0xEBEBEB)
  static let backgroundColor2 = UIColor(hex: 0xD1D1D1) // 중요도 선택 x

  static let gray3 = UIColor(hex: 0x333333)
  static let gray8 = UIColor(hex: 0x888888)
  static let grayA = UIColor(hex: 0xAAAAAA)
  static let grayC = UIColor(hex: 0xCCCCCC)
  static let grayE = UIColor(hex: 0xEEEEEE)
  static let grayF4 = UIColor(hex: 0xF4F4F4)
  static let modalBackground = UIColor(white: 0x000000, alpha: 0.7)
  static let separatorColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)

  static let normalSunday = UIColor(red: 208, green: 2, blue: 27, alpha: 1)
  static let otherMonthSunday = UIColor(red: 208, green: 2, blue: 27, alpha: 0.5)
}

public extension UIColor {
  convenience init(red: Int, green: Int, blue: Int, alpha: Float) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: CGFloat(alpha)
    )
  }

  convenience init(hex: Int, alpha: Float = 1.0) {
    self.init(
      red: (hex >> 16) & 0xff,
      green: (hex >> 8) & 0xff,
      blue: hex & 0xff,
      alpha: alpha
    )
  }
}

