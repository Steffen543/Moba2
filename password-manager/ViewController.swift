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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func passwordTests()
    {
        let Manager = DBPasswordManager();
        let newPassword = Manager.getNewObject();
        
        newPassword.username = "BigBanana";
        newPassword.password = String(arc4random());
        
        Manager.save(password: newPassword);
        Manager.load(passwordId: newPassword.id);
        Manager.load(categoryId: 5);
    }
    
    
    func categoryTests()
    {
        let Manager = DBCategoryManager();
        let newCategory = Manager.getNewObject();
        
        newCategory.name = String(arc4random());
        
        Manager.save(category: newCategory);
        Manager.load(categoryId: newCategory.id);
        let cats = Manager.loadAll();
        
        for cat in cats{
            print("\(cat.passwordCount)");
        }
    }
    
    
    
    
    
    @IBAction func login(_ sender: UIButton) {
        
        
        
        let password = passwordTextField.text;
        
        if (password == "Hallo"){
            
            print("NICHT OK");
            
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
            let newController = storyBoard.instantiateViewController(withIdentifier: "FolderViewController");
            self.present(newController, animated: true, completion: nil);

        }
        
    }

}

