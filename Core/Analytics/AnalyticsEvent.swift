//
//  AnalyticsEvent.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import Core
import Umbrella

public typealias PodoAnalytics = Umbrella.Analytics<AnalyticsEvent>
public let analytics = PodoAnalytics()

public enum AnalyticsEvent {
  case login(AuthProvider)
  case logout

  case todo_create(String)
  case todo_edit
  case todo_edit_done
  case todo_delete

  case login_view
  case main_view
  case calendar_view
  case settings_view
  case about_view
  case license_view
}

extension AnalyticsEvent: EventType {
  public func name(for provider: ProviderType) -> String? {
    switch self {
    case .login: return "로그인"
    case .logout: return "로그아웃"

    case .todo_create: return "일정_생성"
    case .todo_edit: return "일정_수정"
    case .todo_edit_done: return "일정_수정_완료"
    case .todo_delete: return "일정_삭제"

    case .login_view: return "로그인_화면"
    case .main_view: return "메인_화면"
    case .calendar_view: return "캘린더_화면"
    case .settings_view: return "설정_화면"
    case .about_view: return "앱정보_화면"
    case .license_view: return "라이선스_화면"
    }
  }

  public func parameters(for provider: ProviderType) -> [String: Any]? {
    switch self {
    case .login(let provider):
      return ["provider": provider.rawValue()]
    case .todo_create(let title):
      return ["name": title]
    default:
      return nil
    }
  }
}
