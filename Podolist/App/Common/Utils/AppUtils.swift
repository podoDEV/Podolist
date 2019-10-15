//
//  AppUtils.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

class AppUtils {
    static func versionName() -> String {
        var version = "\(InterfaceString.Setting.Version) \(InterfaceString.Signature.AppVersion)"
        #if DEBUG
            version.append(".debug")
        #endif
        return version
    }
}
