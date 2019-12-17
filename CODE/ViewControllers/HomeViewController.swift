//
//  HomeViewController.swift
//  CODE
//
//  Created by Yuhao Zhong on 16.12.19.
//  Copyright © 2019 CODE. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class HomeViewController: UIViewController {
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem?.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent{
            print("Moved back")
            
            do {
                try Auth.auth().signOut()
                try GIDSignIn.sharedInstance().signOut()
                userDefault.removeObject(forKey: "usersignedin")
                userDefault.synchronize()
                navigationController?.popViewController(animated: true)
                print("User signed out")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
