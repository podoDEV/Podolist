//
//  InterfaceString.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

struct InterfaceString {
    struct Login {
        static let SignUp: String = NSLocalizedString("login.signup", comment: "")
        static let SignIn: String = NSLocalizedString("login.signin", comment: "")
    }
    struct Podolist {
        static let Title: String = NSLocalizedString("podolist.title", comment: "")
    }

    struct Write {
        static let Priority: String = NSLocalizedString("write.priority", comment: "")
        static let Date: String = NSLocalizedString("write.date", comment: "")
    }

    struct Priority {
        static let Urgent: String = NSLocalizedString("priority.urgent", comment: "")
        static let High: String = NSLocalizedString("priority.high", comment: "")
        static let Medium: String = NSLocalizedString("priority.medium", comment: "")
        static let Low: String = NSLocalizedString("priority.low", comment: "")
    }

    struct Setting {
        static let Help: String = NSLocalizedString("setting.help", comment: "")
        static let Version: String = NSLocalizedString("setting.version", comment: "")
        static let Feedback: String = NSLocalizedString("setting.feedback", comment: "")
        static let Inquiry: String = NSLocalizedString("setting.inquiry", comment: "")
        static let Logout: String = NSLocalizedString("setting.logout", comment: "")
    }

    struct Commmon {
        static let Podolist: String = NSLocalizedString("common.podolist", comment: "")
        static let OK: String = NSLocalizedString("common.ok", comment: "OK")
        static let Yes: String = NSLocalizedString("common.yes", comment: "Yes")
        static let No: String = NSLocalizedString("common.no", comment: "No")
        static let Cancel: String = NSLocalizedString("common.cancel", comment: "Cancel")
        static let Submit: String = NSLocalizedString("common.submit", comment: "Submit")
        static let Retry: String = NSLocalizedString("common.retry", comment: "Retry")
        static let Delete: String = NSLocalizedString("common.delete", comment: "Delete")
        static let Remove: String = NSLocalizedString("common.remove", comment: "Remove")
        static let Next: String = NSLocalizedString("common.next", comment: "Next button")
        static let Done: String = NSLocalizedString("common.done", comment: "Done button title")
        static let Skip: String = NSLocalizedString("common.skip", comment: "Skip action")
        static let SeeAll: String = NSLocalizedString("common.seeall", comment: "See All title")
        static let Developers: [String] = ["heebuma@gmail.com"]
        static let MessageBody: String = "\n\n\n\n---------------------------------\nMy App: \(InterfaceString.Commmon.Podolist) \nMy Version: \(InterfaceString.Signature.AppVersion) \nMy iOS: \(InterfaceString.Signature.iOSVersion) \n---------------------------------"
        static let Emails: [String] = ["heebuma@gmail.com"]
    }

    struct Error {
        static let MailTitle: String = NSLocalizedString("error.email.title", comment: "")
        static let MailMessage: String = NSLocalizedString("error.email.body", comment: "")
    }

    struct Signature {
        static let Copyright: String = NSLocalizedString("NSHumanReadableCopyright", comment: "copyright")
        static let AppVersion: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        static let AppBuildVersion: String = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        static let iOSVersion: String = UIDevice.current.systemVersion
    }
}
