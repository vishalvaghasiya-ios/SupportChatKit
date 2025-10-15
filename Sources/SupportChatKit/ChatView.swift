//
//  ChatView.swift
//  SupportChatKit
//
//  Created by Nexios Technologies on 15/10/25.
//

import SwiftUI

public struct ChatView: View {
    @State private var messages: [Message] = []
    @State private var inputText: String = ""
    private let userId: String

    public init(userId: String) {
        self.userId = userId
    }

    public var body: some View {
        VStack {
            ScrollViewReader { scroll in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(messages) { msg in
                            Text("\(msg.userId): \(msg.message)")
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity, alignment: msg.userId == userId ? .trailing : .leading)
                        }
                    }.padding()
                }.onChange(of: messages) { _ in
                    if let last = messages.last {
                        scroll.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }
            HStack {
                TextField("Message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    guard !inputText.isEmpty else { return }
                    FirebaseManager.shared.sendMessage(userId: userId, message: inputText) { _ in }
                    inputText = ""
                }
            }.padding()
        }
        .onAppear {
            FirebaseManager.shared.fetchMessages { msgs in
                self.messages = msgs
            }
        }
    }
}
