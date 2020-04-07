//
//  Core.swift
//  Core
//
//  Created by hb1love on 2020/03/24.
//  Copyright © 2020 podo. All rights reserved.
//

import SwiftyBeaver

public final class Core {
    public static func setup() {
        log.addDestination(ConsoleDestination())
    }

    static let authNetworking: AuthNetworking = {
        AuthNetworking(plugins: [])
    }()

    static let todoNetworking: TodoNetworking = {
        TodoNetworking(plugins: [AuthPlugin(authService: authService)])
    }()

    public static let authService: AuthServiceType = {
        AuthService(networking: authNetworking,
                    serviceName: AppUtils.serviceName,
                    accessGroup: AppUtils.keyChainAccessGroup)
    }()

    public static let todoService: TodoServiceType = {
        TodoService(networking: todoNetworking)
    }()

    public static let memberService: MemberServiceType = {
        MemberService(networking: authNetworking)
    }()
}
