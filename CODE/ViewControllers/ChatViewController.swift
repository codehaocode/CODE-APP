//
//  HomeViewController.swift
//  CODE
//
//  Created by CODE Marketing on 06.11.19.
//  Copyright © 2019 CODE. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn




class ChatViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    // Constants
    let db = Firestore.firestore()
    let userDefault = UserDefaults.standard
    
    // Variables
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem?.isEnabled = false
        // tableView.delegate = self
        tableView.dataSource = self
        title = K.appName
        
        // Do any additional setup after loading the view.
        loadMessages()
        
        guard let email = Auth.auth().currentUser?.email else {return}
        emailTextField.text = email
        tabBarItem.title = "Chat"

        
        
        setUpElements()
        
    }
    
    
    
    func setUpElements() {
        // Style the elements
//        Styling.styleTextField(messageTextField)
        Styling.styleFilledButton(sendButton)
    }
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dataField)
            .addSnapshotListener  { (querySnapshot, error) in
                self.messages = []
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let snapShotDocuments = querySnapshot?.documents {
                        for doc in snapShotDocuments {
                            let data = doc.data()
                            if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                    
                                    
                                }
                                
                            }
                        }
                    }
                }
        }
    }
    
    
    // Actions
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dataField: Date().timeIntervalSince1970
            ]) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                    
                }
            }
            
        }
    }
    
    
    
    
//    @IBAction func signOutPressed(_ sender: Any) {
//
//        do {
//            try Auth.auth().signOut()
//            //            try GIDSignIn.sharedInstance().signOut()
//            //            userDefault.removeObject(forKey: "usersignedin")
//            //            userDefault.synchronize()
//            navigationController?.popViewController(animated: true)
//            print("User signed out")
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//
//
//    }
    
    
    
    
    
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].body
        
        // This is a message from the current user.
        if message.sender == Auth.auth().currentUser?.email{
            //            cell.leftImageView.isHidden = true
            //            cell.rightImageView.isHidden = false
            //            cell.messageBubble.backgroundColor = UIColor
            cell.backgroundColor = UIColor.init(red:0.00, green:0.00, blue:0.00, alpha:0.5)
            
        }
            
            // This is a message from other senders.
        else {
            cell.backgroundColor = UIColor.init(red:0.00, green:0.00, blue:0.00, alpha:0.0)
        }
        
        return cell
    }
    
    
}



// Interact with message
//extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}

