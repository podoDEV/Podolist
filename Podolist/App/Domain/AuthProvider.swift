//
//  AuthProvider.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
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
