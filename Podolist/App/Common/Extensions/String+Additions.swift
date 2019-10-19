//
//  String+Additions.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

extension String {
    init(urlOfResourceFile: String) {
        if let path = Bundle.main.path(forResource: urlOfResourceFile, ofType: nil),
            let text = try? String(contentsOfFile: path, encoding: .utf8) {
            self = text
        } else {
            self = ""
        }
    }

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
