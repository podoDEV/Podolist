//
//  String+Additions.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
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
}
