//
//  FirstLaunchView.swift
//  password-manager
//
//  Created by ed-153020 on 10.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit;

class FirstLaunchController : UIViewController{
    @IBOutlet weak var MasterPasswordField: UITextField!;
    
    @IBOutlet weak var MaterPasswordRepeatField: UITextField!;
    
    var PasswordsEqual: Bool = false;
    var PasswordStrong: Bool = false;
    var PasswordRare: Bool = false;
    
    
    override func viewDidLoad() {
        MasterPasswordField.setRightViewFAIcon(icon: .FAExclamationCircle, rightViewMode: .unlessEditing, textColor: .red);
    }
    
    @IBAction func onMasterFieldEditEnd() {
        checkMasterPassword();
    }
    
    @IBAction func onMasterRepeatFieldEditEnd() {
        checkMasterPassword()
    }
    
    @IBAction func onMasterSet() {
        
        if PasswordsEqual && PasswordStrong && PasswordRare {
            SecurityManager.setPasscode(identifier: "master", passcode: String(MasterPasswordField.text!.hashValue));
            UserDefaults.standard.set(true, forKey: "MasterPasswordIsSet");
            
            dismiss(animated: true, completion: nil);
        }
    }
    
    
    func checkMasterPassword() {
        var password = "";
        
        //checking the master field
        password = MasterPasswordField.text!;
        if     SecurityManager.hasUpperAndLowercase(password: password)
            && (SecurityManager.hasNumbers(password: password)
                || SecurityManager.hasSpecialCharacters(password: password))
            && password.characters.count >= 8{
            
            PasswordStrong = true;
        }
        
        if !SecurityManager.isInTop1000(password: password) {
            PasswordRare = true;
        }
        
        if (!PasswordRare || !PasswordStrong) {
            MasterPasswordField.setRightViewFAIcon(icon: .FAExclamationCircle, rightViewMode: .always, textColor: .red);
        } else {
            MasterPasswordField.setRightViewFAIcon(icon: .FACheckCircle, rightViewMode: .always, textColor: .green);
        }
        
        
        //checking the repetition
        if password != MaterPasswordRepeatField.text! {
            PasswordsEqual = false;
            MaterPasswordRepeatField.setRightViewFAIcon(icon: .FAExclamationCircle, rightViewMode: .always, textColor: .red);
        } else {
            PasswordsEqual = true;
            MaterPasswordRepeatField.setRightViewFAIcon(icon: .FACheckCircle, rightViewMode: .always, textColor: .green);
        }
    }
}
