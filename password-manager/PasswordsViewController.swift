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
    @IBOutlet var LabelDescription: UILabel!
 
    
    
    @IBAction func EditFolderButtonClicked(_ sender: Any) {

        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
        navigationItem.backBarButtonItem = backItem
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let newController = storyBoard.instantiateViewController(withIdentifier: "EditFolderViewController");
        
        // get the nav controller
        let navController = newController as! UINavigationController;
        // get the view controller from the nav controller
        let viewController = navController.topViewController as!EditFolderViewController;
        viewController.SelectedFolder = SelectedFolder;
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear");
        let Manager = DBPasswordManager();
        Passwords = Manager.load(categoryId: (SelectedFolder?.id)!)
        MainTableView.reloadData()

        
        title = SelectedFolder?.name;
        LabelDescription.text = SelectedFolder?.descriptionText;
        if(LabelDescription.text == "" || LabelDescription.text == nil)
        {
            LabelDescription.text = "Keine Beschreibung";
        }
        LabelDescription.lineBreakMode = .byWordWrapping;
        LabelDescription.numberOfLines = 0;
        LabelDescription.sizeToFit();
        
        let insets: UIEdgeInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 0.0, right: 10.0)
        LabelDescription.layoutMargins = insets;
    }

    
    @IBAction func AddButtonClick(_ sender: Any) {
        let alert = UIAlertController(title: "Passwort hinzufügen", message: "Geben Sie einen Namen ein", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let text = textField?.text;
            
            if text == "" { return; }
            
            let Manager = DBPasswordManager();
            let newPassword = Manager.getNewObject();
            
            newPassword.name = text;
            newPassword.password = "";
            newPassword.categoryId = (self.SelectedFolder?.id)!;
            newPassword.createDate = NSDate();
            newPassword.editDate = NSDate();
            
            Manager.save(password: newPassword);
            
            self.Passwords?.append(newPassword);
            self.MainTableView.reloadData();
            
            
            let backItem = UIBarButtonItem()
            backItem.title = "Zurück";
            self.navigationItem.backBarButtonItem = backItem
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
            let newController = storyBoard.instantiateViewController(withIdentifier: "EditPasswordController");
            
            // get the nav controller
            let navController = newController as! UINavigationController;
            // get the view controller from the nav controller
            let viewController = navController.topViewController as!EditPasswordController;
            viewController.SelectedPassword = newPassword;
            self.navigationController?.pushViewController(viewController, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
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
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "PasswordCell");
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator;
        let pwd = Passwords![indexPath.row];
        if pwd.mail != "" {
            cell.detailTextLabel?.text = pwd.mail;
        } else {
            cell.detailTextLabel?.text = pwd.username;
        }
        cell.textLabel?.text = pwd.name;
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
        navigationItem.backBarButtonItem = backItem
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedPassword = Passwords?[indexPath.row];
        
        
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
        navigationItem.backBarButtonItem = backItem

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let newController = storyBoard.instantiateViewController(withIdentifier: "ShowPasswordController");
        
        // get the nav controller
        let navController = newController as! UINavigationController;
        // get the view controller from the nav controller
        let viewController = navController.topViewController as!ShowPasswordController;
        viewController.SelectedPassword = selectedPassword;
        navigationController?.pushViewController(viewController, animated: true)
    }
 
}
