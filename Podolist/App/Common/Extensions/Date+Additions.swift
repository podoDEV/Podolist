//
//  Date+Additions.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
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
