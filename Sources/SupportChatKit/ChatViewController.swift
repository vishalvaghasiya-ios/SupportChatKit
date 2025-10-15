//
//  ChatViewController.swift
//  SupportChatKit
//
//  Created by Nexios Technologies on 15/10/25.
//

import UIKit

public class ChatViewController: UIViewController, UITableViewDataSource {
    private let tableView = UITableView()
    private let inputViewBar = ChatInputAccessoryView()
    private var messages = [Message]()
    private let userId: String

    public init(userId: String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupInputView()
        fetchMessages()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupInputView() {
        inputViewBar.onSend = { [weak self] text in
            FirebaseManager.shared.sendMessage(userId: self?.userId ?? "unknown", message: text) { _ in }
        }
        inputViewBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputViewBar)
        NSLayoutConstraint.activate([
            inputViewBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputViewBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputViewBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func fetchMessages() {
        FirebaseManager.shared.fetchMessages { [weak self] msgs in
            self?.messages = msgs
            self?.tableView.reloadData()
            if let count = self?.messages.count, count > 0 {
                self?.tableView.scrollToRow(at: IndexPath(row: count - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { messages.count }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let message = messages[indexPath.row]
        cell.textLabel?.text = "\(message.userId): \(message.message)"
        return cell
    }
}
