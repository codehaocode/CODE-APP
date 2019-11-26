//
//  form.swift
//  CODE
//
//  Created by CODE Marketing on 06.11.19.
//  Copyright © 2019 CODE. All rights reserved.
//

import Foundation
import UIKit

class Form {
    
    static func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return emailTest.evaluate(with: email)
        }
    

    static func isValidPassword(_ password: String) -> Bool {
        let regex = "(?=^.{8,}$)(?=.*\\d)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return passwordTest.evaluate(with: password)
        }
     
    
}

