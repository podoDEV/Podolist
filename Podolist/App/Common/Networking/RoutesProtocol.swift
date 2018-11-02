//
//  RoutesProtocol.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import Alamofire

protocol URLRouter {
    static var basePath: String { get }
}

// These are routes throughout the application.
// Typically this is conformed to by methods routes.
protocol Routable {
    typealias Parameters = [String: Any]
    typealias Query = String
    var route: String { get set }
    var urlParams: String! { get set }
    init()
}

extension Routable {

    // Create instance of Object that conforms to Routable
    init(_ _arg: String = "") {
        self.init()
        urlParams = _arg
    }

    // Allows a route to become a nested route
    func nestedRoute(args: String, child: RequestConverterProtocol) -> RequestConverter {
        return RequestConverter(method: child.method,
                                route: "\(self.route)/\(args)/\(child.route)",
                                parameters: child.parameters)
    }

    // Generate the URL string for generated nested routes
    func nestedRouteURL(parent: Routable, child: Routable) -> String {
        let nestedRoute = "\(parent.route)/\(parent.urlParams!)/" + child.route
        return nestedRoute
    }
}

// Allows a route to perform the `.get` method
protocol Readable: Routable { }

extension Readable where Self: Routable {

    // Method that allows route to return an object
    //
    // Parameter:
    //  - params: Parameters of the object that is being returned
    // Returns: `URLRequestConvertible` object to play nicely with Alamofire
    //
    // Router.User.get(params: "2")
    //
    static func get(param: String) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)/\(param)"
        return RequestConverter(method: .get, route: route)
    }

    static func get(parameters: Parameters) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)"
        return RequestConverter(method: .get, route: route, parameters: parameters)
    }
}

// Allows a route to perform the `.post` method
protocol Creatable: Routable { }

extension Creatable where Self: Routable {

    // Method that allows route to create an object
    //
    // Parameter:
    //  - parameters: Dictionary of objects that will be used to create object
    // Returns: `URLRequestConvertible` object to play nicely with Alamofire
    //
    // Router.User.create(parameters: ["username":"initFabian", "github":"https://github.com/initFabian"])
    //
    static func create(parameters: Parameters = [:]) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)"
        return RequestConverter(method: .post, route: route, parameters: parameters)
    }
}

// Allows a route to perform the `.put` method
protocol Updatable: Routable { }

extension Updatable where Self: Routable {

    // Method that allows route to update an object
    //
    // Parameter:
    //  - params: Parameters of the object that is being updated
    //  - parameters: Dictionary of objects that will be used to create object
    // Returns: `URLRequestConvertible` object to play nicely with Alamofire
    //
    // Router.User.update(params: "2", parameters: ["twitterURL":"https://twitter.com/initFabian"])
    //
    static func update(params: String, parameters: Parameters) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)/\(params)"
        return RequestConverter(method: .put, route: route, parameters: parameters)
    }
}

// Allows a route to perform the `.delete` method
protocol Deletable: Routable { }

extension Deletable where Self: Routable {

    // Method that allows route to delete an object
    //
    // Parameter:
    //  - params: Parameters of the object that is being deleted
    // Returns: `URLRequestConvertible` object to play nicely with Alamofire
    //
    // Router.User.delete(params: "2")
    //
    static func delete(params: String) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)/\(params)"
        return RequestConverter(method: .delete, route: route)
    }
}

// Protocol that conforms to URLRequestConvertible to all Alamofire integration
protocol RequestConverterProtocol: URLRequestConvertible {
    var method: HTTPMethod { get set }
    var route: String { get set }
    var parameters: Parameters { get set }
}

// Converter object that will allow us to play nicely with Alamofire
struct RequestConverter: RequestConverterProtocol {
    var method: HTTPMethod
    var route: String
    var parameters: Parameters = [:]

    // Create a RequestConverter object
    //
    // Parameters:
    //  - method: Method to perform on router. Example: `.get`, `.post`, etc.
    //  - route: Route endpoint on url.
    //  - parameters: Optional dictionary to pass in objects. Used for `.post` and `.put`
    init(method: HTTPMethod, route: String, parameters: Parameters = [:]) {
        self.method = method
        self.route = route
        self.parameters = parameters
    }

    // Required method to conform to the `URLRequestConvertible` protocol.
    //
    // Returns: URLRequest object
    // Throws: An `Error` if the underlying `URLRequest` is `nil`.
    func asURLRequest() throws -> URLRequest {
        let url = try Router.basePath.asURL()
        let urlRequest = try URLRequest(url: url.appendingPathComponent(route), method: method)

        return try JSONEncoding.default.encode(urlRequest, with: parameters)
    }
}
