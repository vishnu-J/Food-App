//
//  Logger.swift
//  Zomato
//
//  Created by Vishnu on 26/11/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//
import Foundation

/// Enum which maps an appropiate symbol which added as prefix for each log message
///
/// - error: Log type error
/// - info: Log type info
/// - debug: Log type debug
/// - verbose: Log type verbose
/// - warning: Log type warning
/// - severe: Log type severe
enum LogEvent: String {
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
    case nl = "[⛑]" // network logs
    case bd = "[☂️]" // Before Debug
    case ut = "[🚥]"  // Unit Testing
}


/// Wrapping Swift.print() within DEBUG flag
///
/// - Note: *print()* might cause [security vulnerabilities]( )
///
/// - Parameter object: The object which is to be logged
///
func print(_ object: Any) {
    Swift.print(object)
}

public class Logger {
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    public static var isBDLogEnabled = true
    
    public static var isLoggingEnabled: Bool = false
    
    public static var isUnitTestLoggingEnabled = false
    
    // MARK: - Loging methods
    
    /// Logs error messages on console with prefix [‼️]
    ///
    /// - Parameters:
    ///   - tag: Tag name of the corresponding log
    ///   - object: Object or message to be logged
    ///   - line: Line number in file from where the logging is done
    public static func e(_ tag: String, _ object: Any, line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.e.rawValue) GG[\(tag)] | \(line): \(object)")
        }
    }
    
    /// Logs info messages on console with prefix [ℹ️]
    ///
    /// - Parameters:
    ///   - tag: Tag name of the corresponding log
    ///   - object: Object or message to be logged
    ///   - line: Line number in file from where the logging is done
    public static func i(_ tag: String, _ object: Any, line: Int = #line) {
        print("\(Date().toString()) \(LogEvent.i.rawValue) GG[\(tag)] | \(line): \(object)")
    }
    
    /// Logs debug messages on console with prefix [💬]
    ///
    /// - Parameters:
    ///   - tag: Tag name of the corresponding log
    ///   - object: Object or message to be logged
    ///   - line: Line number in file from where the logging is done
    public static func d(_ tag: String, _ object: Any, line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.d.rawValue) GG[\(tag)] | \(line): \(object)")
        }
    }
    
    public static func d(_ tag: String, _ object: Any, _ error: Error, line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.d.rawValue) GG[\(tag)] | \(line): [ERROR] \(object) \n \(error.localizedDescription)")
        }
    }
    
    /// Logs debug messages on console with prefix [⛑]
    ///
    /// - Parameters:
    ///   - tag: Tag name of the corresponding log
    ///   - object: Object or message to be logged
    ///   - line: Line number in file from where the logging is done
    public static func nl(_ tag: String, _ object: Any, line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.nl.rawValue) GG[\(tag)] | \(line): \(object)")
        }
    }
    
    /// Logs messages verbosely on console with prefix [🔬]
    ///
    /// - Parameters:
    ///   - tag: Tag name of the corresponding log
    ///   - object: Object or message to be logged
    ///   - line: Line number in file from where the logging is done
    public static func v(_ tag: String, _ object: Any, line: Int = #line) {
        print("\(Date().toString()) \(LogEvent.v.rawValue) GG[\(tag)] | \(line): \(object)")
    }
    
    /// Logs warnings verbosely on console with prefix [⚠️]
    ///
    /// - Parameters:
    ///   - tag: Tag name of the corresponding log
    ///   - object: Object or message to be logged
    ///   - line: Line number in file from where the logging is done
    public static func w(_ tag: String, _ object: Any, line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.w.rawValue) GG[\(tag)] | \(line): \(object)")
        }
    }
    
    /// Logs severe events on console with prefix [🔥]
    ///
    /// - Parameters:
    ///   - tag: Tag name of the corresponding log
    ///   - object: Object or message to be logged
    ///   - line: Line number in file from where the logging is done
    public static func s(_ tag: String, _ object: Any, line: Int = #line) {
        if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.s.rawValue) GG[\(tag)] | \(line): \(object)")
        }
    }
    
    /// Logs information that needs to be logged before enabling debug logs [☂️]
    ///
    /// - Parameters:
    ///   - tag: Tag name of the corresponding log
    ///   - object: Object or message to be logged
    ///   - line: Line number in file from where the logging is done
    public static func bd(_ tag: String, _ object: Any, line: Int = #line) {
        if isBDLogEnabled {
            print("\(Date().toString()) \(LogEvent.bd.rawValue) GG[\(tag)] | \(line): \(object)")
        } else if isLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.bd.rawValue) GG[\(tag)] | \(line): \(object)")
        }
    }
    
    
    /// Logs information that needs to be logged before enabling debug logs [🚥]
    ///
    /// - Parameters:
    ///   - tag: Tag name of the corresponding log
    ///   - object: Object or message to be logged
    ///   - line: Line number in file from where the logging is done
    public static func ut(_ tag: String, _ object: Any, line: Int = #line) {
        if isUnitTestLoggingEnabled {
            print("\(Date().toString()) \(LogEvent.ut.rawValue) GG[\(tag)] | \(line): \(object)")
        }
    }
    
    /// Extract the file name from the file path
    ///
    /// - Parameter filePath: Full file path in bundle
    /// - Returns: File Name with extension
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

internal extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}
