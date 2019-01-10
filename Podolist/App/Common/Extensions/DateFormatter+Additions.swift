//
//  DateFormatter+Additions.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

extension DateFormatter {

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
