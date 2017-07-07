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
  
    @IBOutlet var MainTableView: UITableView!
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PasswordCell")
        title = SelectedFolder?.name;
        let Manager = DBPasswordManager();
        Passwords = Manager.load(categoryId: (SelectedFolder?.id)!)
        

        definesPresentationContext = true

        print(Passwords?.count);
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Passwords!.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath);
        
        cell.textLabel?.text = Passwords![indexPath.row].name;
        cell.detailTextLabel?.text = "TEST";
            
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
        navigationItem.backBarButtonItem = backItem
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        /*let selectedFolder = Folders?[indexPath.row];
        
        
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
        navigationItem.backBarButtonItem = backItem
        
        let destinationVC = PasswordsViewController()
        destinationVC.SelectedFolder = selectedFolder
        
        
        //destinationVC.performSegue(withIdentifier: "showPasswordsSegue", sender: self)
        navigationController?.pushViewController(destinationVC, animated: true)
        
         
         
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
         
         
         
         */
        
    }
    
    
    
}
