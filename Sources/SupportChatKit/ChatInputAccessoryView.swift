//
//  ChatInputAccessoryView.swift
//  SupportChatKit
//
//  Created by Nexios Technologies on 15/10/25.
//

import UIKit

public class ChatInputAccessoryView: UIView {
    public let textView = UITextView()
    private let sendButton = UIButton(type: .system)
    public var onSend: ((String) -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { super.init(coder: coder) }

    private func setupUI() {
        backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.font = .systemFont(ofSize: 16)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [textView, sendButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            sendButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc private func sendTapped() {
        guard !textView.text.isEmpty else { return }
        onSend?(textView.text)
        textView.text = ""
    }
}
