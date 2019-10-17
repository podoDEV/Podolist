//
//  Setting.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

enum SettingSectionType {
    case info
    case others
    case logout
}

enum SettingRowType: String {
    case account
    case about
    case license
    case feedback
    case logout
}

protocol SettingSectionProtocol {
    var type: SettingSectionType { get }
    var rows: [SettingRowProtocol] { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension SettingSectionProtocol {
    var rowCount: Int {
        return 1
    }
}

struct SettingInfoSection: SettingSectionProtocol {
    var type: SettingSectionType {
        return .info
    }

    var sectionTitle: String {
        return ""
    }

    var rowCount: Int {
        return 3
    }

    var rows: [SettingRowProtocol]
}

struct SettingOthersSection: SettingSectionProtocol {
    var type: SettingSectionType {
        return .others
    }

    var sectionTitle: String {
        return ""
    }

    var rows: [SettingRowProtocol]
}

struct SettingLogoutSection: SettingSectionProtocol {
    var type: SettingSectionType {
        return .logout
    }

    var sectionTitle: String {
        return ""
    }

    var rows: [SettingRowProtocol]
}

protocol SettingRowProtocol {
    var type: SettingRowType { get set }
    var title: String { get set }
    var image: UIImage { get set }
}

protocol SettingAccountRowProtocol: SettingRowProtocol {
    var name: String { get set }
    var email: String? { get set }
}

struct SettingRow: SettingRowProtocol {
    var type: SettingRowType
    var title: String
    var image: UIImage
}

struct SettingAccountRow: SettingAccountRowProtocol {
    var type: SettingRowType
    var title: String
    var image: UIImage
    var name: String
    var email: String?
}
