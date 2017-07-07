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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        /*let password = RandomPassword();
        password.useLowerCase();
        password.useUpperCase();
        password.useNumbers();
        password.useSpeciaCharaters();
        
        let passwordString = password.getPassword(length: 16);
        print("Passwort: \(passwordString)");
        SecurityManager.setPasscode(identifier: "root", passcode: passwordString);
        */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        
        let password = passwordTextField.text;
        if (password != SecurityManager.getPasscode(identifier: "root")){
            print("PASSWORT NICHT OK");
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let newController = storyBoard.instantiateViewController(withIdentifier: "FolderViewController");
        self.present(newController, animated: true, completion: nil);
    }

}

