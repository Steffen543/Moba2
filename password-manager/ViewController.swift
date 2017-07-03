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
    
    func createPassword() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newPassword = NSEntityDescription.insertNewObject(forEntityName: "Password", into: managedContext) as! Password
        
        
        newPassword.username = "wtf"
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        //let newPassword = Password(context: managedContext)
        
        
        
    }
    @IBAction func login(_ sender: UIButton) {
        let password = passwordTextField.text;
        
        if (password == "Hallo"){
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
            let newController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController;
            
            self.present(newController, animated: true, completion: nil);
            
            
        }
        else{
            /*let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
            let newController = storyBoard.instantiateViewController(withIdentifier: "FolderTableView") as! FolderTableViewController;
            
            self.present(newController, animated: true, completion: nil);*/

        }
        
    }

}

