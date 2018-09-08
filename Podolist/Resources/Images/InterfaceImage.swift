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

    // MARK: - Common
    case logo = "podolist_logo"
    case back = "back"

    func image(_ style: Style) -> UIImage? {
        switch style {
        case .normal:   return normalImage
        case .white:    return whiteImage
        case .selected: return selectedImage
        case .disabled: return disabledImage
        }
    }

    fileprivate func pngNamed(_ name: String) -> UIImage {
        return UIImage(named: "\(name).png")!
    }

    var normalImage: UIImage! {
        switch self {
        case .back:
            return pngNamed(self.rawValue)
        default:
            return pngNamed("\(self.rawValue)_normal")
        }
    }

    var selectedImage: UIImage! {
        switch self {
        case .back:
            return pngNamed(self.rawValue)
        default:
            return pngNamed("\(self.rawValue)_selected")
        }
    }

    var whiteImage: UIImage? {
        switch self {
        case .back:
            return pngNamed("\(self.rawValue)_white")
        default:
            return nil
        }
    }

    var disabledImage: UIImage? {
        switch self {
        case .back:
            return pngNamed("\(self.rawValue)_disabled")
        default:
            return nil
        }
    }
}
