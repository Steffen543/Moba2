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
    
    public var SelectedPassword : Password?;
    
    @IBOutlet weak var MasterPasswordField: UITextField!;
    
    @IBOutlet weak var MaterPasswordRepeatField: UITextField!;
    
    override func viewDidLoad() {
        MasterPasswordField.setRightViewFAIcon(icon: .FAExclamationCircle, rightViewMode: .unlessEditing, textColor: .red);
    }
    
    @IBAction func onMasterFieldEditEnd() {
    }
    
    @IBAction func onMasterRepeatFieldEditEnd() {
    }
    
    @IBAction func onMasterSet() {
        
        if MasterPasswordField.text! == MaterPasswordRepeatField.text! {
            UserDefaults.standard.set(true, forKey: "MasterPasswordIsSet");
            SecurityManager.setPasscode(identifier: "master", passcode: String(MasterPasswordField.text!.hashValue));
            
            dismiss(animated: true, completion: nil);
        }
    }
}
