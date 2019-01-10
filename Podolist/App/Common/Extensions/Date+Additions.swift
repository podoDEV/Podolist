//
//  Date+Additions.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

extension Date {

    func displayYYYYMMDD() -> String {
        let formatter = DateFormatter.displayFormatterOfyyyyMMdd()
        return formatter.string(from: self)
    }

    func stringYYYYMMDD() -> String {
        let formatter = DateFormatter.dateFormatterOfyyyyMMdd()
        return formatter.string(from: self)
    }
}
