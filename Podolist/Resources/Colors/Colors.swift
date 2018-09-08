//
//  Colors.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

private struct PodolistColors {
    static let appColor: UIColor = UIColor(hex: 0xF86A0E)
    static let appColorLight: UIColor = UIColor(hex: 0xFDCDAE)
    static let grayF1: UIColor = UIColor(hex: 0xF1F1F1)
    static let grayF2: UIColor = UIColor(hex: 0xF2F2F2)
    static let grayF4: UIColor = UIColor(hex: 0xF4F4F4)
    static let modalBackground: UIColor = UIColor(white: 0x000000, alpha: 0.7)
}

extension UIColor {

    class func appColor() -> UIColor { return PodolistColors.appColor }
    class func appColorLight() -> UIColor { return PodolistColors.appColorLight }

    // MARK: - Common
    class func grayF1() -> UIColor { return PodolistColors.grayF1 }
    class func grayF2() -> UIColor { return PodolistColors.grayF2 }
    class func grayF4() -> UIColor { return PodolistColors.grayF4 }
    class func modalBackground() -> UIColor { return PodolistColors.modalBackground }
}
