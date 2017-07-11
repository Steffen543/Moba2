//
//  ViewController.swift
//  password-manager
//
//  Created by sk-153353 on 03.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import UIKit
import CoreData
import LocalAuthentication

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SecureIconLabel: UILabel!
    @IBOutlet weak var FingerSignLabel: UILabel!
    @IBOutlet weak var FingerStrack: UIStackView!
    
    
    
    override func viewDidLoad() {
        SecureIconLabel.setFAIcon(icon: .FAShield, iconSize: 100);
        FingerSignLabel.setFAIcon(icon: .FAHandOUp, iconSize: 100);
        
        
        var AuthenticationContext = LAContext();
        var error: NSError?;
        if AuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            FingerStrack.isHidden = false;
            
            AuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock Passwordmanager",
                                                 reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
                    let newController = storyBoard.instantiateViewController(withIdentifier: "FirstLaunchController");
                    
                    self.present(newController, animated: true, completion: nil);
                }else {
                
                    // Check if there is an error
                    if let error = error {
                        let alert = UIAlertController(title: "Touch ID Fehler", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.actionSheet);
                    } else {
                        GeneralHelper.shakeElement(field: self.FingerStrack);
                    }
                }
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //check if this is the first launch. Redirect if true for master passwort generation
        let masterPasswordIsSet = UserDefaults.standard.bool(forKey: "MasterPasswordIsSet")
        if !masterPasswordIsSet {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
            let newController = storyBoard.instantiateViewController(withIdentifier: "FirstLaunchController");
            
            self.present(newController, animated: true, completion: nil);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        
        let password = String(passwordTextField.text!.hashValue);
        if (password == SecurityManager.getPasscode(identifier: "master")){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
            let newController = storyBoard.instantiateViewController(withIdentifier: "FolderViewController");
            
            self.present(newController, animated: true, completion: nil);
        }
        else {
            GeneralHelper.shakeElement(field: passwordTextField);
        }
    }
}

