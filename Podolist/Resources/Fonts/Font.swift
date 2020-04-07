//
//  Font.swift
//  Podolist
//
//  Created by hb1love on 2019/10/28.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

public extension UIFont {

    class func appFontB(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans-Bold", size: size)!
    }

    class func appFontL(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans-Light", size: size)!
    }

    class func appFontM(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans-Medium", size: size)!
    }

    class func appFontR(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans-Regular", size: size)!
    }
}
