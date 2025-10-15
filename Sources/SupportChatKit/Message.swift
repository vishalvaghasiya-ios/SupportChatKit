//
//  Message.swift
//  SupportChatKit
//
//  Created by Nexios Technologies on 15/10/25.
//

import Firebase

public struct Message: Identifiable {
    public let id = UUID()
    public let userId: String
    public let message: String
    public let timestamp: Date

    public init(userId: String, message: String, timestamp: Date) {
        self.userId = userId
        self.message = message
        self.timestamp = timestamp
    }

    public init?(dictionary: [String: Any]) {
        guard let userId = dictionary["userId"] as? String,
              let message = dictionary["message"] as? String,
              let timestamp = dictionary["timestamp"] as? Timestamp else { return nil }
        self.userId = userId
        self.message = message
        self.timestamp = timestamp.dateValue()
    }
}
