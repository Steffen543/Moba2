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
    @IBOutlet weak var SecureIconLabel: UILabel!
    @IBOutlet weak var WarningLabel: UILabel!
    
    var PasswordsEqual: Bool = false;
    var PasswordStrong: Bool = false;
    var PasswordRare: Bool = false;

    override func viewDidLoad() {
        MasterPasswordField.setRightViewFAIcon(icon: .FAExclamationCircle, rightViewMode: .unlessEditing, textColor: .red);
        SecureIconLabel.setFAIcon(icon: .FAShield, iconSize: 100);
    }

    @IBAction func onMasterFieldEditEnd() {
        let password = MasterPasswordField.text!;
        WarningLabel.isHidden = true;
        
        //checking the master field
        if     SecurityManager.hasUpperAndLowercase(password: password)
            && (SecurityManager.hasNumbers(password: password)
                || SecurityManager.hasSpecialCharacters(password: password))
            && password.characters.count >= 8{
            
            PasswordStrong = true;
            MasterPasswordField.setRightViewFAIcon(icon: .FACheckCircle, rightViewMode: .always, textColor: .green);
        } else {
            MasterPasswordField.setRightViewFAIcon(icon: .FAExclamationCircle, rightViewMode: .always, textColor: .red);
            PasswordStrong = false;
        }
    }

    @IBAction func onMasterRepeatFieldEditEnd() {
        let password = MasterPasswordField.text!;
        
        //checking the repetition
        if password != MaterPasswordRepeatField.text! {
            PasswordsEqual = false;
            MaterPasswordRepeatField.setRightViewFAIcon(icon: .FAExclamationCircle, rightViewMode: .always, textColor: .red);
        } else {
            PasswordsEqual = true;
            MaterPasswordRepeatField.setRightViewFAIcon(icon: .FACheckCircle, rightViewMode: .always, textColor: .green);
        }
    }
    
    @IBAction func onMasterSet() {
        
        if PasswordsEqual && PasswordStrong {
            SecurityManager.setPasscode(identifier: "master", passcode: String(MasterPasswordField.text!.hashValue));
            UserDefaults.standard.set(true, forKey: "MasterPasswordIsSet");
            
            dismiss(animated: true, completion: nil);
        }
        else {
            if (!PasswordStrong) {
                GeneralHelper.shakeElement(field: MasterPasswordField);
            }
            
            if (!PasswordsEqual) {
                GeneralHelper.shakeElement(field: MaterPasswordRepeatField);
            }
        }
    }
    
    @IBAction func MasterEditEnd(_ sender: Any) {
        if SecurityManager.isInTop1000(password: MasterPasswordField.text!) {
            MasterPasswordField.setRightViewFAIcon(icon: .FAExclamationTriangle, rightViewMode: .always, textColor: .orange);
            WarningLabel.isHidden = false;
        } else {
            WarningLabel.isHidden = true;
        }
    }
}
