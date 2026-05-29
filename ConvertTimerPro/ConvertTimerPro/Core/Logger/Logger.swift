//
//  Logger.swift
//  IssuerUIExtension
//
//  Created by hungld10 on 7/6/25.
//  Copyright © 2025 VPBank. All rights reserved.
//

import Foundation

enum LogLevel: String {
    case debug = "🐞 DEBUG"
    case info = "ℹ️ INFO"
    case warning = "⚠️ WARNING"
    case error = "❌ ERROR"
    case testFlight = "🧪 TESTFLIGHT"
    case production = "🛍️ PROD"
}

struct Logger {
    
    /// Gọi log ra console kèm thông tin file, dòng và hàm
    static func log(_ message: String = "",
                    level: LogLevel = .info,
                    function: String = #function,
                    file: String = #file,
                    line: Int = #line) {
        
        let fileName = (file as NSString).lastPathComponent
        let timestamp = Logger.timestamp()
        let composedMessage = "[\(timestamp)] [\(fileName):\(line)] \(function) ➡️ \(message)"
        
        #if DEBUG
        // Chạy khi build Debug
        NSLog("\(LogLevel.debug.rawValue): \(composedMessage)")
        #else
        // Build Release: phân biệt TestFlight và App Store
        if isTestFlight {
            NSLog("\(LogLevel.testFlight.rawValue): \(composedMessage)")
        } else {
            print("\(LogLevel.production.rawValue): \(composedMessage)")
        }
        #endif
    }
    
    static func log<T: Encodable>(object: T,
                                   level: LogLevel = .info,
                                   function: String = #function,
                                   file: String = #file,
                                   line: Int = #line) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        
        do {
            let data = try encoder.encode(object)
            if let json = String(data: data, encoding: .utf8) {
                log(json, level: level, function: function, file: file, line: line)
            } else {
                log("⚠️ Failed to encode object to JSON string.", level: .error, function: function, file: file, line: line)
            }
        } catch {
            log("❌ Encoding error: \(error)", level: .error, function: function, file: file, line: line)
        }
    }
    
    /// Check nếu đang chạy TestFlight (qua sandboxReceipt)
    private static var isTestFlight: Bool {
        if let receiptURL = Bundle.main.appStoreReceiptURL {
            return receiptURL.lastPathComponent == "sandboxReceipt"
        }
        return false
    }

    /// Thời gian log định dạng HH:mm:ss
    private static func timestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date())
    }
}
