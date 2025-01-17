//
//  Logger.swift
//  Podolist
//
//  Created by hb1love on 2019/10/18.
//  Copyright © 2019 podo. All rights reserved.
//

import CocoaLumberjack
import Scope

extension DDLogFlag {
    public var level: String {
        switch self {
        case DDLogFlag.error: return "❤️ ERROR"
        case DDLogFlag.warning: return "💛 WARNING"
        case DDLogFlag.info: return "💙 INFO"
        case DDLogFlag.debug: return "💚 DEBUG"
        case DDLogFlag.verbose: return "💜 VERBOSE"
        default: return "☠️ UNKNOWN"
        }
    }
}

private class LogFormatter: NSObject, DDLogFormatter {

    static let dateFormatter = DateFormatter().also {
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }

    public func format(message logMessage: DDLogMessage) -> String? {
        let timestamp = LogFormatter.dateFormatter.string(from: logMessage.timestamp)
        let level = logMessage.flag.level
        let filename = logMessage.fileName
        let function = logMessage.function ?? ""
        let line = logMessage.line
        let message = logMessage.message.components(separatedBy: "\n").joined(separator: "\n    ")
        return "\(timestamp) \(level) \(filename).\(function):\(line) - \(message)"
    }

    private func formattedDate(from date: Date) -> String {
        return LogFormatter.dateFormatter.string(from: date)
    }

}

/// A shared instance of `Logger`.
let log = Logger()

final class Logger {

    init() {
        setenv("XcodeColors", "YES", 0)

        // TTY = Xcode console
        DDTTYLogger.sharedInstance.let {
            $0.logFormatter = LogFormatter()
            $0.colorsEnabled = false /*true*/ // Note: doesn't work in Xcode 8
            $0.setForegroundColor(DDMakeColor(30, 121, 214), backgroundColor: nil, for: .info)
            $0.setForegroundColor(DDMakeColor(50, 143, 72), backgroundColor: nil, for: .debug)
            DDLog.add($0)
        }

        // File logger
        DDFileLogger().also {
            $0.rollingFrequency = TimeInterval(60 * 60 * 24)  // 24 hours
            $0.logFileManager.maximumNumberOfLogFiles = 7
            DDLog.add($0)
        }
    }

    func e(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogError(message, file: file, function: function, line: line)
    }

    func w(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogWarn(message, file: file, function: function, line: line)
    }

    func i(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogInfo(message, file: file, function: function, line: line)
    }

    func d(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogDebug(message, file: file, function: function, line: line)
    }

    func v(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        let message = self.message(from: items)
        DDLogVerbose(message, file: file, function: function, line: line)
    }

    private func message(from items: [Any]) -> String {
        return items
            .map { String(describing: $0) }
            .joined(separator: " ")
    }
}
