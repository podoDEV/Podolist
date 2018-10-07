//
//  AppUtils.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Foundation

class AppUtils {
    static var isIphoneX: Bool {
        if #available(iOS 11.0, *) {
            var topPadding: CGFloat = 0
            switch UIDevice.current.orientation {
            case .portrait:
                topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
            case .portraitUpsideDown:
                topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            case .landscapeLeft:
                topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.left ?? 0
            case .landscapeRight:
                topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.right ?? 0
            default:
                topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
            }
            if topPadding > 0 {
                return true
            }
        }
        return false
    }
}
