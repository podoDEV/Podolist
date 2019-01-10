//
//  InterfaceString.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

struct InterfaceString {

    struct Login {
        static let Kakao = NSLocalizedString("login.kakao", comment: "")
        static let Anonymous = NSLocalizedString("login.anonymous", comment: "")
    }

    struct Write {
        static let Priority = NSLocalizedString("write.priority", comment: "")
        static let Date = NSLocalizedString("write.date", comment: "")
    }

    struct Edit {
        static let Editing = NSLocalizedString("edit.editing", comment: "")
        static let Cancel = NSLocalizedString("edit.cancel", comment: "")
    }

    struct Priority {
        static let Urgent = NSLocalizedString("priority.urgent", comment: "")
        static let High = NSLocalizedString("priority.high", comment: "")
        static let Medium = NSLocalizedString("priority.medium", comment: "")
        static let Low = NSLocalizedString("priority.low", comment: "")
        static let None = NSLocalizedString("priority.none", comment: "")
    }

    struct List {
        static let DelayedItems = NSLocalizedString("list.delayedItems", comment: "")
        static let Items = NSLocalizedString("list.items", comment: "")
    }

    struct Setting {
        static let Title = NSLocalizedString("setting", comment: "")
        static let About = NSLocalizedString("setting.about", comment: "")
        static let Version = NSLocalizedString("setting.about.version", comment: "")
        static let License = NSLocalizedString("setting.license", comment: "")
        static let Feedback = NSLocalizedString("setting.feedback", comment: "")
        static let Logout = NSLocalizedString("setting.logout", comment: "")
    }

    struct Commmon {
        static let Podolist = NSLocalizedString("common.podolist", comment: "")
        static let OK = NSLocalizedString("common.ok", comment: "OK")
        static let Yes = NSLocalizedString("common.yes", comment: "Yes")
        static let No = NSLocalizedString("common.no", comment: "No")
        static let Cancel = NSLocalizedString("common.cancel", comment: "Cancel")
        static let Submit = NSLocalizedString("common.submit", comment: "Submit")
        static let Retry = NSLocalizedString("common.retry", comment: "Retry")
        static let Delete = NSLocalizedString("common.delete", comment: "Delete")
        static let Remove = NSLocalizedString("common.remove", comment: "Remove")
        static let Next = NSLocalizedString("common.next", comment: "Next button")
        static let Done = NSLocalizedString("common.done", comment: "Done button title")
        static let Skip = NSLocalizedString("common.skip", comment: "Skip action")
        static let SeeAll = NSLocalizedString("common.seeall", comment: "See All title")
        static let Developers = ["podo.devops@gmail.com", "heebuma@gmail.com"]
        static let Subject = "[Feedback] "
        static let Info = """
        \n\n\n\n
        ---------------------------------
        My App: \(InterfaceString.Commmon.Podolist)
        My Version: \(InterfaceString.Signature.AppVersion)(\(InterfaceString.Signature.AppBuildVersion))
        My iOS: \(InterfaceString.Signature.iOSVersion)
        ---------------------------------
        """
    }

    struct Error {
        static let MailTitle = NSLocalizedString("error.email.title", comment: "")
        static let MailBody = NSLocalizedString("error.email.body", comment: "")
    }

    struct Signature {
        static let Copyright = NSLocalizedString("signature.copyright", comment: "copyright")
        static let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        static let AppBuildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        static let iOSVersion = UIDevice.current.systemVersion
    }
}
