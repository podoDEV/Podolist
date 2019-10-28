//
//  MemberService.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

protocol MemberServiceType {
    var current: Account? { get }

    func me(_ completion: @escaping (Result<Account, PodoError>) -> Void)
}

final class MemberService: MemberServiceType {
    private let networking: AuthNetworking

    private(set) var current: Account?

    init(networking: AuthNetworking) {
        self.networking = networking
    }

    func me(_ completion: @escaping (Result<Account, PodoError>) -> Void) {
        networking.request(.me) { [weak self] (result: (Result<Account, PodoError>)) -> Void in
            switch result {
            case .success(let account):
                self?.current = account
                completion(.success((account)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
