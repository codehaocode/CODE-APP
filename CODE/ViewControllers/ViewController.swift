//
//  ViewController.swift
//  CODE
//
//  Created by CODE Marketing on 06.11.19.
//  Copyright © 2019 CODE. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class ViewController: UIViewController, AppDelegateLoginDelegate {

    
    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
   
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    // Variables
    
    
    // Constants
    let userDefault = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           navigationController?.isNavigationBarHidden = true
       }
       
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
           navigationController?.isNavigationBarHidden = false
       }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.loginDelegate = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        // ...     
        
        
        setUpElements()

        
    }

    func setUpElements() {
        
        
        // Style the elements
        Styling.styleTextField(emailTextField)
        Styling.styleTextField(passwordTextField)
        Styling.styleFilledButton(loginButton)

    }

    
    override func viewDidAppear(_ animated: Bool) {
        if userDefault.bool(forKey: "usersignedin") {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.loginDelegate = self
            
        }
    }
    
    
    
    
    
    func createUser(email:String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                // User Created
                print("User Created")
                // Sign in user
                self.signInUser(email: email, password: password)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
   
    
    func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                // Signed in
                print("User Signed in")
                self.userDefault.set(true, forKey: "usersignedin")
                self.userDefault.synchronize()
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            } else if (error?._code == AuthErrorCode.userNotFound.rawValue){
                self.createUser(email: email, password: password) } else {
                print(error)
                print(error?.localizedDescription)
            }
        }
        
    }

    func didSuccessfullyPerformLogin() {
        self.performSegue(withIdentifier: K.loginSegue, sender: self)
    }
    
    
    @IBAction func signInButtonPressed(_ sender: Any) {
    
        signInUser(email: emailTextField.text!, password: passwordTextField.text!)
        
    
    }
    
    // Actions
    
    
    
    
}

