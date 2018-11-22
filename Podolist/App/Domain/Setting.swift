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
    var rows: [SettingRow] { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension SettingSectionProtocol {
    var rowCount: Int {
        return 1
    }
}

class SettingInfoSection: SettingSectionProtocol {
    var type: SettingSectionType {
        return .info
    }

    var sectionTitle: String {
        return " "
    }

    var rowCount: Int {
        return 3
    }

    var rows: [SettingRow]

    init(rows: [SettingRow]) {
        self.rows = rows
    }
}

class SettingOthersSection: SettingSectionProtocol {
    var type: SettingSectionType {
        return .others
    }

    var sectionTitle: String {
        return " "
    }

    var rows: [SettingRow]

    init(rows: [SettingRow]) {
        self.rows = rows
    }
}

class SettingLogoutSection: SettingSectionProtocol {
    var type: SettingSectionType {
        return .logout
    }

    var sectionTitle: String {
        return " "
    }

    var rows: [SettingRow]

    init(rows: [SettingRow]) {
        self.rows = rows
    }
}

protocol SettingRowProtocol {
//    var type: SettingRowType { get set }
//    var title: String { get set }
//    var imageUrl: String { get set }
}

struct SettingRow: SettingRowProtocol {
    var type: SettingRowType?
    var title: String?
    var image: UIImage?
}

struct SettingAccountRow: SettingRowProtocol {
    var type: SettingRowType?
    var title: String?
    var image: UIImage?
}
