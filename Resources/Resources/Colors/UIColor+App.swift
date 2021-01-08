
import UIKit
import SwiftUI

// MARK: - Login
public extension UIColor {
  
  static var loginLogo: UIColor = .init(
    light: .init(hex: 0x9E30FE),
    dark: .init(hex: 0x9E30FE)
  )
  
  static var kakaoLoginBackground: UIColor = .init(
    light: .init(r: 255, g: 232, b: 18, a: 1),
    dark: .init(r: 255, g: 232, b: 18, a: 1)
  )
}

// MARK: - Todo
public extension UIColor {
  static var todoBackground: UIColor = .init(
    light: .init(r: 158, g: 48, b: 254, a: 1),
    dark: .init(r: 158, g: 48, b: 254, a: 1)
  )
  
  static var todoText: UIColor = .init(
    light: .init(r: 255, g: 255, b: 255, a: 1),
    dark: .init(r: 255, g: 255, b: 255, a: 1)
  )
  
  static var todoDoneBackground: UIColor = .init(
    light: .init(r: 222, g: 185, b: 255, a: 1),
    dark: .init(r: 222, g: 185, b: 255, a: 1)
  )
  
  static var delayedText: UIColor = .init(
    light: .init(r: 208, g: 2, b: 27, a: 1),
    dark: .init(r: 208, g: 2, b: 27, a: 1)
  )
  
  static var todayText: UIColor = .init(
    light: .init(r: 0, g: 0, b: 0, a: 1),
    dark: .init(r: 0, g: 0, b: 0, a: 1)
  )
  
  static var priorityUrgent: UIColor = .init(
    light: .init(r: 255, g: 0, b: 0, a: 1),
    dark: .init(r: 255, g: 0, b: 0, a: 1)
  )
  
  static var priorityHigh: UIColor = .init(
    light: .init(r: 254, g: 166, b: 35, a: 1),
    dark: .init(r: 254, g: 166, b: 35, a: 1)
  )
  
  static var priorityMedium: UIColor = .init(
    light: .init(r: 126, g: 211, b: 33, a: 1),
    dark: .init(r: 126, g: 211, b: 33, a: 1)
  )
  
  static var priorityLow: UIColor = .init(
    light: .init(r: 80, g: 227, b: 194, a: 1),
    dark: .init(r: 80, g: 227, b: 194, a: 1)
  )
  
  static var priorityNone: UIColor = .init( // deprecated
    light: .init(hex: 0x4A90E2),
    dark: .init(hex: 0x4A90E2)
  )
  
  static var priortyDone: UIColor = .init(
    light: .init(r: 215, g: 215, b: 215, a: 1),
    dark: .init(r: 215, g: 215, b: 215, a: 1)
  )
}

// MARK: - Calendar
public extension UIColor {
  static var calendarText: UIColor = .init(
    light: .init(r: 255, g: 255, b: 255, a: 1),
    dark: .init(r: 255, g: 255, b: 255, a: 1)
  )
  
  static var selectedDate: UIColor = .init(
    light: .init(r: 144, g: 19, b: 254, a: 1),
    dark: .init(r: 144, g: 19, b: 254, a: 1)
  )
  
  static var selectedDateBackground: UIColor = .init(
    light: .init(r: 255, g: 255, b: 255, a: 1),
    dark: .init(r: 255, g: 255, b: 255, a: 1)
  )
  
  static var sunday: UIColor = .init(
    light: .init(r: 255, g: 0, b: 0, a: 1),
    dark: .init(r: 255, g: 0, b: 0, a: 1)
  )
  
  static var otherMonthDate: UIColor = .init(
    light: .init(r: 255, g: 255, b: 255, a: 0.5),
    dark: .init(r: 255, g: 255, b: 255, a: 0.5)
  )
  
  static var otherMonthSunday: UIColor = .init(
    light: .init(r: 208, g: 2, b: 27, a: 0.5),
    dark: .init(r: 208, g: 2, b: 27, a: 0.5)
  )
  
  
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
  static let separatorColor = UIColor(r: 230, g: 230, b: 230, a: 1)

  static let normalSunday = UIColor(r: 208, g: 2, b: 27, a: 1)
}

public extension UIColor {
  convenience init(r: Int, g: Int, b: Int, a: Float) {
    assert(r >= 0 && r <= 255, "Invalid red component")
    assert(g >= 0 && g <= 255, "Invalid green component")
    assert(b >= 0 && b <= 255, "Invalid blue component")

    self.init(
      red: CGFloat(r) / 255.0,
      green: CGFloat(g) / 255.0,
      blue: CGFloat(b) / 255.0,
      alpha: CGFloat(a)
    )
  }

  convenience init(hex: Int, alpha: Float = 1.0) {
    self.init(
      r: (hex >> 16) & 0xff,
      g: (hex >> 8) & 0xff,
      b: hex & 0xff,
      a: alpha
    )
  }
  
  convenience init(light: UIColor, dark: UIColor) {
    self.init { traitCollection in
      if traitCollection.userInterfaceStyle == .dark {
        return dark
      } else {
        return light
      }
    }
  }
}
