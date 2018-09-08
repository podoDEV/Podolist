//
//  Fonts.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

enum PodolistFonts {
    case logo
    case navigation
    case podoTitle
    case podoSubTitle
    case etc
}

extension UIFont {
    class func appFontB(size: CGFloat) -> UIFont {
        return UIFont(name: "SeoulNamsanB", size: size)!
    }

    class func appFontM(size: CGFloat) -> UIFont {
        return UIFont(name: "SeoulNamsanM", size: size)!
    }

    class func preferredFont(textStyle: PodolistFonts) -> UIFont {
        switch textStyle {
        case .logo:
            return UIFont.boldSystemFont(ofSize: 36.0)
        case .navigation:
            return UIFont.appFontB(size: 18.0)
        case .podoTitle:
            return UIFont.appFontB(size: 15.0)
        case .podoSubTitle:
            return UIFont.appFontB(size: 14.0)
        default:
            return UIFont.appFontM(size: 15.0)
        }
    }
}
