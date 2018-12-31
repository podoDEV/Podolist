//
//  DateFormatter+Additions.swift
//  Podolist
//
//  Created by NHNEnt on 29/12/2018.
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
