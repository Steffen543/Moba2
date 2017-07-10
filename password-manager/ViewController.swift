//
//  ViewController.swift
//  password-manager
//
//  Created by sk-153353 on 03.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var passwordTextField: UITextField!
    
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

