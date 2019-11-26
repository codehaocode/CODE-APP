//
//  Utilities.swift
//  CODE
//
//  Created by CODE Marketing on 06.11.19.
//  Copyright © 2019 CODE. All rights reserved.
//

import Foundation
import UIKit

class Styling {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y:textfield.frame.height - 2, width: textfield.frame.width, height: 2)

//        bottomLine.backgroundColor = UIColor.init(red:48/255, green:173/255, blue:99/255, alpha:1).cgColor
        bottomLine.backgroundColor = UIColor.init(red:0.00, green:0.00, blue:0.00, alpha:1.0).cgColor
        

        // Remove border on text field
        textfield.borderStyle = .none

        // Add the line to the text filed
        textfield.layer.addSublayer(bottomLine)
    
    }
    
    
    static func styleFilledButton(_ button: UIButton) {
        
        // Filled round corner style
        button.backgroundColor = UIColor.init(red:0.00, green:0.00, blue:0.00, alpha:1.0)
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.white
        
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.black
    }
    
     
    
}
