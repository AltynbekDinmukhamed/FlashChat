//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Димаш Алтынбек on 08.03.2023.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    //MARK: -Views-
    
    let chatTable: UITableView = {
        let table = UITableView()
        table.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let messageStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mesageTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Write a message..."
        text.font = .systemFont(ofSize: 14, weight: .medium)
        text.layer.cornerRadius = 5
        text.backgroundColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var messageSendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var logOutButton = UIBarButtonItem(title: "Log out", style: .done, target: self, action: #selector(logOutButtonTapped))
    
    var messages: [Message] = []
    
    let db = Firestore.firestore()
    
    //MARK: -Life Cycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        navigationController?.isNavigationBarHidden = false
        chatTable.delegate = self
        chatTable.dataSource = self
        loadMessage()
    }
    //MARK: -Functions-
    private func setUpViews() {
        view.backgroundColor = UIColor(named: "BrandPurple")
        view.addSubview(chatTable)
        view.addSubview(messageStack)
        messageStack.addArrangedSubview(mesageTextField)
        messageStack.addArrangedSubview(messageSendButton)
        view.addSubview(chatTable)
        NSLayoutConstraint.activate([
            messageStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            messageStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            messageStack.heightAnchor.constraint(equalToConstant: 60),
            
            mesageTextField.topAnchor.constraint(equalTo: messageStack.topAnchor, constant: 10),
            mesageTextField.bottomAnchor.constraint(equalTo: messageStack.bottomAnchor, constant: -10),
            
            
            chatTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTable.bottomAnchor.constraint(equalTo: messageStack.topAnchor)
        ])
        navigationItem.rightBarButtonItem = logOutButton
        navigationItem.hidesBackButton = true
        
    }
    
    func loadMessage() {
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dataFieldd).addSnapshotListener { (querySnapShot, error) in
            
            self.messages = []
            
            if let e = error {
                print("There is error to retrive data from Firestore: \(e)")
            }else {
                if let snaphotDocuments = querySnapShot?.documents {
                    for doc in snaphotDocuments {
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.chatTable.reloadData()
                                let index = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatTable.scrollToRow(at: index, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    //MARK: -LifeCycle-
    @objc func logOutButtonTapped(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("error siging out: %@", signOutError)
        }
    }
    
    @objc func sendButtonTapped() {
        if let messageBody = mesageTextField.text, let messeageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messeageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dataFieldd: Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print("There was a issiue: \(e)")
                } else {
                    print("message sucsecfully sended")
                    DispatchQueue.main.async {
                        self.mesageTextField.text = ""
                    }
                }
            }
        }
    }
}

//MARK: -Extension-
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChatTableViewCell
        cell.labelText.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.secoundLogoImageView.isHidden = true
            cell.logoImageView.isHidden = false
            cell.labelText.backgroundColor = UIColor(named: "BrandLightPurple")
        } else {
            cell.secoundLogoImageView.isHidden = false
            cell.logoImageView.isHidden = true
            cell.labelText.backgroundColor = UIColor(named: "BrandPurple")
        }
        return cell
    }
    
}
