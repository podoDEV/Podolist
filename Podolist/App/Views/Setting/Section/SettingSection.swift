//
//  SettingSection.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

enum SettingRowType: String {
    case account
    case about
    case license
    case feedback
    case logout
}

protocol SettingRowProtocol {
    var type: SettingRowType { get set }
    var title: String { get set }
    var image: UIImage? { get set }
}

protocol SettingAccountRowProtocol: SettingRowProtocol {
    var name: String { get set }
    var email: String? { get set }
    var imageUrl: String? { get set }
}

struct SettingRow: SettingRowProtocol {
    var type: SettingRowType
    var title: String
    var image: UIImage?
}

struct SettingAccountRow: SettingAccountRowProtocol {
    var type: SettingRowType
    var title: String
    var image: UIImage?

    var name: String
    var email: String?
    var imageUrl: String?
}
