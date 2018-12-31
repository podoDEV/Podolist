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

    let sessionKey = "SessionKey"
    let accountkey = "AccountKey"

    private init() {
        keychain = Keychain(service: "com.podo.podolist")
    }

    func hasSession() -> Bool {
        if let value = try? keychain.getString(sessionKey), let val = value, !val.isEmpty {
            return true
        }
        return false
    }

    func save(session: Session, onCompleted: (() -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        do {
            try keychain.set(session, key: sessionKey)
            if let onCompleted = onCompleted {
                onCompleted()
            }
        } catch let error {
            if let onError = onError {
                onError(error)
            }
        }
    }

    func findSession(onSuccess: ((String?) -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
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

    func deleteSession(onCompleted: (() -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        do {
            try keychain.remove(sessionKey)
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

// MARK: - Account

extension KeychainService {

    func save(account: Account, onCompleted: (() -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: account)

        do {
            try keychain.set(data, key: accountkey)
            onCompleted?()
        } catch let error {
            log.w(error, "failed to save account")
            onError?(error)
        }
    }

    func findAccount(onCompleted: ((Account) -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        var accountData: Data?

        if let data = try? keychain.getData(accountkey) {
            accountData = data
        }

        guard let data = accountData, let account = NSKeyedUnarchiver.unarchiveObject(with: data) as? Account else {
            log.w("failed to find account")
            onError?(NSError())
            return
        }

        onCompleted?(account)
    }
}
