//
//  KeychainService.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import KeychainAccess
import RxSwift

final class KeychainService {
    static let shared = KeychainService()
    let keychain: Keychain

    let sessionKey = "session"

    private init() {
        keychain = Keychain(service: "com.podo.podolist")
    }

    func hasValue(key: String) -> Bool {
        if let value = try? keychain.getString(key), let val = value, !val.isEmpty {
            return true
        }
        return false
    }

    func saveValue(key: String, value: String, onCompleted: (() -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        do {
            try keychain.set(value, key: key)
            if let onCompleted = onCompleted {
                onCompleted()
            }
        } catch let error {
            if let onError = onError {
                onError(error)
            }
        }
    }

//    func hasValue(key: String) -> Completable? {
//        return Completable.create { completable in
//            if let value = try? self.keychain.getString(key), let token = value, !token.isEmpty {
//                completable(.completed)
//            } else {
//                completable(.error(NSError()))
//            }
//            return Disposables.create {}
//        }
//    }
//
//    @discardableResult
//    func saveValue(key: String, value: String) -> Completable? {
//        return Completable.create { completable in
//            do {
//                try self.keychain.set(value, key: key)
//                completable(.completed)
//            } catch let error {
//                completable(.error(error))
//            }
//            return Disposables.create {}
//        }
//    }

    func findValue(onSuccess: ((String?) -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        if let token = try? keychain.getString(sessionKey) {
            if let onSuccess = onSuccess {
                onSuccess(token)
            }
        } else {
            if let onError = onError {
                onError(NSError())
            }
        }
    }

    func deleteValue(key: String, onCompleted: (() -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        do {
            try keychain.remove(key)
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
