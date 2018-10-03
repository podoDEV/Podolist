//
//  Colors.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

private struct PodolistColors {

    static var selectedDayBackgroundColor = UIColor(hex: 0xD6ABFB)
    static var todayBackgroundColor = UIColor(hex: 0xF9F9F9)
    static var normalDayTextColor = UIColor(hex: 0x9000FE)

    static let appColor = UIColor(hex: 0xF86A0E)
    static let appColorLight = UIColor(hex: 0xFDCDAE)

    static let gray3 = UIColor(hex: 0x333333)
    static let gray8 = UIColor(hex: 0x888888)
    static let grayA = UIColor(hex: 0xAAAAAA)
    static let grayC = UIColor(hex: 0xCCCCCC)
    static let grayE = UIColor(hex: 0xEEEEEE)
    static let grayF4 = UIColor(hex: 0xF4F4F4)
    static let modalBackground = UIColor(white: 0x000000, alpha: 0.7)
}

extension UIColor {

    static var appColor: UIColor { return PodolistColors.appColor }
    static var appColorLight: UIColor { return PodolistColors.appColorLight }

    static var gray3: UIColor { return PodolistColors.gray3 }
    static var gray8: UIColor { return PodolistColors.gray8 }
    static var grayA: UIColor { return PodolistColors.grayA }
    static var grayC: UIColor { return PodolistColors.grayC }
    static var grayE: UIColor { return PodolistColors.grayE }
    static var grayF4: UIColor { return PodolistColors.grayF4 }
    static var modalBackground: UIColor { return PodolistColors.modalBackground }
}
