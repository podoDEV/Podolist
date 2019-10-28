//
//  AnalyticsEvent.swift
//  Podolist
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import Firebase
import Umbrella

typealias PodoAnalytics = Umbrella.Analytics<AnalyticsEvent>
let analytics = PodoAnalytics()

enum AnalyticsEvent {
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
}

extension AnalyticsEvent: EventType {
    func name(for provider: ProviderType) -> String? {
        switch self {
        case .login:
            switch provider {
            case is FirebaseProvider:
                return Firebase.AnalyticsEventLogin
            default:
                return "로그인"
            }
        case .logout: return "로그아웃"

        case .todo_create: return "일정 생성"
        case .todo_edit: return "일정 수정"
        case .todo_edit_done: return "일정 수정 완료"
        case .todo_delete: return "일정 삭제"

        case .login_view: return "로그인 화면"
        case .main_view: return "메인 화면"
        case .calendar_view: return "캘린더 화면"
        case .settings_view: return "설정 화면"
        }
    }

    func parameters(for provider: ProviderType) -> [String: Any]? {
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
