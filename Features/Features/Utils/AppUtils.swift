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

  public static func versionName() -> String {
    var version = "setting.about.version".localized + " " + AppVersion
    #if DEBUG
    version.append(".debug")
    #endif
    return version
  }
}
