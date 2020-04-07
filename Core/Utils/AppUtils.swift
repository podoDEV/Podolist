//
//  AppUtils.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

public class AppUtils {

    public static let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    public static let AppBuildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    public static let iOSVersion = UIDevice.current.systemVersion

    public static var baseURL: String {
        #if DEBUG
        return "http://podolist.podo.world:8000/"
        #else
        return "http://podolist.podo.world:8000/"
        #endif
    }

    public static func versionName() -> String {
        var version = "setting.about.version".localized + " " + AppVersion
        #if DEBUG
            version.append(".debug")
        #endif
        return version
    }

    public static var serviceName: String {
        return "com.podo.podolist.test"
    }

    public static var keyChainAccessGroup: String {
        #if DEBUG
        return "7KW522KWZF.com.podo.podolist.test.shared"
        #else
        return "7KW522KWZF.com.podo.podolist.shared"
        #endif
    }
}
