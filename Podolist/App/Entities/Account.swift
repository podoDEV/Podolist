//
//  Account.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

class Account: NSObject, NSCoding {
    var name: String
    var profile: UIImage
    var email: String?

    init(
        name: String,
        profile: UIImage,
        email: String?
        ) {
        self.name = name
        self.profile = profile
        self.email = email
    }

    convenience init(
        responseAccount: ResponseAccount,
        profile: UIImage
        ) {
        self.init(name: responseAccount.name,
                  profile: profile,
                  email: responseAccount.email)
    }

    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.profile = UIImage(named: "ic_profile")!
        if let profile = aDecoder.decodeObject(forKey: "profile") as? UIImage {
            self.profile = profile
        }
        self.email = aDecoder.decodeObject(forKey: "email") as? String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.profile, forKey: "profile")
        aCoder.encode(self.email, forKey: "email")
    }
}
