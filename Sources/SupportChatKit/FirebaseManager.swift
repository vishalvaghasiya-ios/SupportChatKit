//
//  FirebaseManager.swift
//  SupportChatKit
//
//  Created by Nexios Technologies on 15/10/25.
//

import Firebase
import FirebaseFirestore

public class FirebaseManager {
    public static let shared = FirebaseManager()
    private init() {}

    public func configureFirebase() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    private var db: Firestore { Firestore.firestore() }

    public func sendMessage(userId: String, message: String, completion: @escaping (Error?) -> Void) {
        let data: [String: Any] = [
            "userId": userId,
            "message": message,
            "timestamp": Timestamp()
        ]
        db.collection("support_messages").addDocument(data: data, completion: completion)
    }

    public func fetchMessages(completion: @escaping ([Message]) -> Void) {
        db.collection("support_messages").order(by: "timestamp").addSnapshotListener { snapshot, _ in
            let messages = snapshot?.documents.compactMap { Message(dictionary: $0.data()) } ?? []
            completion(messages)
        }
    }
}
