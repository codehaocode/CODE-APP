//
//  AppDelegate.swift
//  CODE
//
//  Created by CODE Marketing on 07.11.19.
//  Copyright © 2019 CODE. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import IQKeyboardManagerSwift



protocol AppDelegateLoginDelegate: AnyObject {
    func didSuccessfullyPerformLogin()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
   
    let userDefault = UserDefaults()
    
    weak var loginDelegate: AppDelegateLoginDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db)
       
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
    
        return true
    }
    
    // Open URL
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    // Signin handler
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
              print("The user has not signed in before or they have since signed out.")
            } else {
              print("\(error.localizedDescription)")
            }
            
            return
        }
        
        // Perform any operations on signed in user here.
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        print(fullName)
        Auth.auth().signIn(with: credential) { (result, error) in
                if error == nil {
                    self.userDefault.set(true, forKey: "usersignedin")
                    self.userDefault.synchronize()
                    self.loginDelegate?.didSuccessfullyPerformLogin()
                    print("logined in to Google")
                    

    

                } else {
                    print(error?.localizedDescription)
                }
            }
        
         
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
               withError error: Error!) {
       // Perform any operations when the user disconnects from app here.
     
        
    }

    
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//            print("The user has not signed in before or they have since signed out.")
//          } else {
//            print("\(error.localizedDescription)")
//          }
//          return
//        }
//
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                          accessToken: authentication.accessToken)
//        // ...
//
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//          if let error = error {
//            // ...
//            return
//          }
//          // User is signed in
//          // ...
//          // Perform any operations on signed in user here.
//          let userId = user.userID                  // For client-side use only!
//          let idToken = user.authentication.idToken // Safe to send to the server
//          let fullName = user.profile.name
//          let givenName = user.profile.givenName
//          let familyName = user.profile.familyName
//          let email = user.profile.email
//
//          let db = Firestore.firestore()
//          db.collection("users").addDocument(data: ["firstname":givenName,"lastname":familyName, "uid":idToken, "email":email])
//
//
//
//        // ...
//        }
//
//
//
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
//              withError error: Error!) {
//      // Perform any operations when the user disconnects from app here.
//      // ...
//    }
//
//
//    }
        


    // MARK: UISceneSession Lifecycle
    

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
    



