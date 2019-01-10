//
//  Router.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

struct Router: URLRouter {
    static var basePath: String {
        return (Bundle.main.infoDictionary!["BASE_URL"] as! String).replacingOccurrences(of: "\\", with: "")
    }

    struct Login: Creatable {
        var route = "login"
        var urlParams: String!
    }

    struct Logout: Creatable {
        var route = "logout"
        var urlParams: String!
    }

    struct Podolist: Readable, Creatable, Updatable, Deletable {
        var route = "items"
        var urlParams: String!
    }

//    struct Status: Readable, Creatable, Updatable, Deletable, hasPictures {
//        var route = "status"
//        var urlParams: String!
//    }
//
//    struct Picture: Readable, Creatable, Deletable {
//        var route = "pictures"
//        var urlParams: String!
//    }
}

//protocol hasStatuses { }
//extension hasStatuses where Self: Routable {
//    func status(params: String) -> Router.Status {
//        var child = Router.Status(params)
//        child.route = nestedRouteURL(parent: self, child: child)
//        return child
//    }
//
//    func getStatus(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Router.Status.get(params: params))
//    }
//
//    func createStatus(parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Router.Status.create(parameters: parameters))
//    }
//
//    func deleteStatus(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Router.Status.delete(params: params))
//    }
//}
//
//protocol hasPictures { }
//extension hasPictures where Self: Routable {
//    func picture(params: String) -> Router.Picture {
//        var child = Router.Picture(params)
//        child.route = nestedRouteURL(parent: self, child: child)
//        return child
//    }
//
//    func getPicture(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Router.Picture.get(params: params))
//    }
//
//    func createPicture(parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Router.Picture.create(parameters: parameters))
//    }
//
//    func deletePicture(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Router.Picture.delete(params: params))
//    }
//}
