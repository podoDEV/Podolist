//
//  AppUtils.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

class AppUtils {
    static let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    static let AppBuildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    static let iOSVersion = UIDevice.current.systemVersion

    static var baseURL: String {
        return "http://api.dev.podolist.com:8000/"
    }

    static func versionName() -> String {
        var version = "setting.about.version".localized + " " + AppVersion
        #if DEBUG
            version.append(".debug")
        #endif
        return version
    }
}
