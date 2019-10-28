//
//  InterfaceImage.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

enum InterfaceImage: String {
    enum Style {
        case normal
        case white
        case selected
        case disabled
    }

    case kakaologin = "ic_kakaoLogin"
    case logo = "ic_logo"
    case logo2 = "ic_logo2"
    case add = "ic_add"
    case create = "ic_create"
    case dropdown = "ic_dropdown"
    case setting = "ic_setting"
    case calendar = "bg_calendar"
    case complete = "ic_complete"
    case none

    func image(_ style: Style) -> UIImage? {
        switch style {
        case .normal:   return normalImage
        case .white:    return whiteImage
        case .selected: return selectedImage
        case .disabled: return disabledImage
        }
    }

    func pngNamed(_ name: String) -> UIImage {
        return UIImage(named: "\(name).png")!
    }

    var normalImage: UIImage! {
        switch self {
        case .logo,
             .logo2,
             .add,
             .create,
             .dropdown,
             .calendar,
             .setting,
             .complete,
             .kakaologin:
            return pngNamed(self.rawValue)
        default:
            return pngNamed("\(self.rawValue)_normal")
        }
    }

    var selectedImage: UIImage! {
        switch self {
        case .add,
             .create,
             .dropdown,
             .calendar,
             .setting:
            return pngNamed(self.rawValue)
        default:
            return pngNamed("\(self.rawValue)_selected")
        }
    }

    var whiteImage: UIImage? {
        switch self {
        case .add:
            return pngNamed("\(self.rawValue)_white")
        default:
            return nil
        }
    }

    var disabledImage: UIImage? {
        switch self {
        case .add:
            return pngNamed("\(self.rawValue)_disabled")
        default:
            return nil
        }
    }
}
