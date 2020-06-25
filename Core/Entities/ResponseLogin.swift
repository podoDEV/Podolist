//
//  ResponseLogin.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

public class ResponseLogin: Codable {
  public var sessionId: String?
  public var user: Account?
}
