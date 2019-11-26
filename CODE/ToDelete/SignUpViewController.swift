//
//  SignUpViewController.swift
//  CODE
//
//  Created by CODE Marketing on 06.11.19.
//  Copyright © 2019 CODE. All rights reserved.
//

import UIKit
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
        
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Styling.styleTextField(firstNameTextField)
        Styling.styleTextField(lastNameTextField)
        Styling.styleTextField(emailTextField)
        Styling.styleTextField(passwordTextField)
        Styling.styleFilledButton(signUpButton)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message.
//   func validateFields() -> String?{
//
//       // check that all fields are filled in
//       if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//          lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//           emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//           passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
//           return "Please fill in all fields."
//       }
//       return nil
//   }
//
//    @IBAction func signUpTapped(_ sender: Any) {
//    // Validate the fields
//            let error = validateFields()
//
//            if error != nil {
//                showError(error!)
//            }
//            else {
//
//                // Create cleaned versions of the data
//                let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//                let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//
//                // Create the user
//
//                Auth.auth().createUser(withEmail:email, password: password) { (result, err) in
//
//                    // Check for erros
//                    if err != nil {
//                        // There was an error creating the user()
//                        self.showError("Error creating user")
//                    }
//                    else{
//                        // User was created successfully, now store the first name and last name
//                        let db = Firestore.firestore()
//
//                        db.collection("users").addDocument(data: ["firstname":firstName,"lastname":lastName, "uid":result!.user.uid]) { (Error) in
//
//                            if error != nil {
//                                // Show error message
//                                self.showError("Error saving user data")
//                            }
//                        }
//                        // Transition to the home screen
//                        self.transitionToHome()
//
//
//
//                    }
//                }
//
//
//
//            }
//
//        }
//
//        func showError(_ message:String){
//
//            errorLabel.text = message
//            errorLabel.alpha = 1
//        }
//
//        func transitionToHome() {
//
//        }
        
    }
