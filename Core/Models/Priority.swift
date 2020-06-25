//
//  Priority.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

public enum Priority: String, Codable {
  case urgent
  case high
  case medium
  case low
  case none
}

public extension Priority {
  func toString() -> String {
    switch self {
    case .urgent:
      return "priority.urgent".localized
    case .high:
      return "priority.high".localized
    case .medium:
      return "priority.medium".localized
    case .low:
      return "priority.low".localized
    case .none:
      return "priority.none".localized
    }
  }

  func backgroundColor() -> UIColor {
    switch self {
    case .urgent:
      return .priorityColor1
    case .high:
      return .priorityColor2
    case .medium:
      return .priorityColor3
    case .low:
      return .priorityColor4
    case .none:
      return .priorityColor5
    }
  }
}
