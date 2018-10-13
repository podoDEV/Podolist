//
//  KeychainService.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import KeychainAccess

final class KeychainService {

    static let shared = KeychainService()
    let keychain: Keychain

    private init() {
        keychain = Keychain(service: "com.podo.podolist")
    }

    func hasToken() -> Bool {
        if let value = try? keychain.getString("key"), let token = value, !token.isEmpty {
            return true
        }
        return false
    }

    func saveToken(token: String, onCompleted: (() -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        do {
            try keychain.set(token, key: "key")
        } catch let error {
            if let onError = onError {
                onError(error)
            }
            return
        }

        if let onCompleted = onCompleted {
            onCompleted()
        }
    }

    func findToken(onSuccess: ((String?) -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        if let token = try? keychain.getString("key") {
            if let onSuccess = onSuccess {
                onSuccess(token)
            }
        } else {
            if let onError = onError {
                onError(NSError())
            }
        }
    }

    func deleteToken(onCompleted: (() -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        do {
            try keychain.remove("key")
        } catch let error {
            if let onError = onError {
                onError(error)
            }
            return
        }

        if let onCompleted = onCompleted {
            onCompleted()
        }
    }
}
