//
//  AuthProvider.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

enum AuthProvider {
    case kakao(String)
    case anonymous(String)

    func rawValue() -> String {
        switch self {
        case .kakao:
            return "kakao"
        case .anonymous:
            return "anonymous"
        }
    }
}
