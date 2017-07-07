//
//  PasswordsViewController.swift
//  password-manager
//
//  Created by sk-153353 on 04.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit;

class PasswordsViewController : UITableViewController{
    
    public var SelectedFolder : Category?;
    var Passwords : [Password]?;
    @IBOutlet weak var MainTableView: UITableView!
    
    @IBAction func AddButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Passwort hinzufügen", message: "Geben Sie einen Namen ein", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let text = textField?.text;
            
            if text == "" { return; }
            
            let Manager = DBPasswordManager();
            let newPassword = Manager.getNewObject();
            
            newPassword.name = text;
            
            Manager.save(password: newPassword);
            
            self.Passwords?.append(newPassword);
            self.MainTableView.reloadData();
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = SelectedFolder?.name;
        let Manager = DBPasswordManager();
        Passwords = Manager.load(categoryId: (SelectedFolder?.id)!)
        
        print(Passwords?.count);
        
    }
    
    
    
}
