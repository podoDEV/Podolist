//
//  Account.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

class Account: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    var provider: String?
    var providerId: String?
//
//    init(
//        name: String,
//        profile: UIImage,
//        email: String?
//        ) {
//        self.name = name
//        self.profile = profile
//        self.email = email
//    }
//
//    convenience init(
//        responseAccount: ResponseAccount,
//        profile: UIImage
//        ) {
//        self.init(name: responseAccount.name,
//                  profile: profile,
//                  email: responseAccount.email)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        self.name = aDecoder.decodeObject(forKey: "name") as! String
//        self.profile = UIImage(named: "ic_profile")!
//        if let profile = aDecoder.decodeObject(forKey: "profile") as? UIImage {
//            self.profile = profile
//        }
//        self.email = aDecoder.decodeObject(forKey: "email") as? String
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.name, forKey: "name")
//        aCoder.encode(self.profile, forKey: "profile")
//        aCoder.encode(self.email, forKey: "email")
//    }
}
