//
//  LoginViewController.swift
//  EdpOnline
//  Autor : Igor Clemente dos Santos
//  Updare: 15/11/2017 - 23:20
//  Created by Igor Clemente dos Santos on 10/11/17.
//  Copyright © 2017 MACBOOK AIR. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var uiUsernameField: UITextField?
    @IBOutlet weak var uiPasswordField: UITextField?
    
    override func viewDidLoad() {
       super.viewDidLoad()
    }
  
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let usernameField = self.uiUsernameField,
              let passwordField = self.uiPasswordField else {
              return true
        }
        
        let fieldsMap:[UITextField:UITextField?] = [
            usernameField : passwordField,
            passwordField : nil
        ]
        
        if let fieldSelected = fieldsMap[textField] ?? UITextField() {
            fieldSelected.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return false
    }
}
