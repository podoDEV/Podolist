//
//  DateFormatter+Additions.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

public extension DateFormatter {

  static func displayFormatterOfyyyyMMdd() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    formatter.calendar = Calendar(identifier: .gregorian)
    return formatter
  }
  
  static func dateFormatterOfyyyyMMdd() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    formatter.calendar = Calendar(identifier: .gregorian)
    return formatter
  }
}
