//
//  Logger.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import Foundation

class Logger {

    class func t(message: String, function: String = #function, file: String = #file, line: Int = #line, callStack: [String] = Thread.callStackSymbols) {
        logging(level: .trace, message: message, function: function, file: file, line: line, callStack: callStack)
    }

    class func d(message: String, function: String = #function, file: String = #file, line: Int = #line) {
        logging(level: .debug, message: message, function: function, file: file, line: line)
    }

    class func i(message: String, function: String = #function, file: String = #file, line: Int = #line) {
        logging(level: .info, message: message, function: function, file: file, line: line)
    }

    class func w(message: String, function: String = #function, file: String = #file, line: Int = #line) {
        logging(level: .warning, message: message, function: function, file: file, line: line)
    }

    class func e(message: String, function: String = #function, file: String = #file, line: Int = #line, callStack: [String] = Thread.callStackSymbols) {
        logging(level: .error, message: message, function: function, file: file, line: line, callStack: callStack)
    }

    class func f(message: String, function: String = #function, file: String = #file, line: Int = #line, callStack: [String] = Thread.callStackSymbols) {
        logging(level: .fatal, message: message, function: function, file: file, line: line, callStack: callStack)
    }
}

private extension Logger {

    class func logging(level: LogLevel, message: String, function: String, file: String, line: Int, callStack: [String] = []) {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium

        let nowdate = dateFormatter.string(from: now)

        var filename = file
        if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
            filename = String(filename[match])
        }

        print("[\(level.description)] \(nowdate) \(function) in \(filename):\(line) :: \(message)")
    }
}

enum LogLevel: String {
    case trace
    case debug
    case info
    case warning
    case error
    case fatal

    var description: String {
        return String(describing: self).uppercased()
    }
}
