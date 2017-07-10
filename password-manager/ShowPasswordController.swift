//
//  ShowPasswordController.swift
//  password-manager
//
//  Created by sk-153353 on 10.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit

class ShowPasswordController : UIViewController{
    
    public var SelectedPassword : Password?;
    var passwordIsVisible : Bool?;
    
    @IBOutlet var LabelDescription: UILabel!
    @IBOutlet var LabelName: UILabel!
    @IBOutlet var LabelPassword: UILabel!
    @IBOutlet var LabelEmail: UILabel!
    @IBOutlet var LabelUsername: UILabel!
    @IBOutlet var LabelEdited: UILabel!
    @IBOutlet var LabelAdded: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = SelectedPassword?.name;
        
        print("Opening password with name \(SelectedPassword?.name)");
        
        
        
       // ViewPasswordIcon.layer.cornerRadius = 10;
    }

    override func viewWillAppear(_ animated: Bool) {
        LabelName.text = SelectedPassword?.name;
        LabelDescription.text = SelectedPassword?.descriptionText;
        
        
        if(SelectedPassword?.password != "" || SelectedPassword?.password != nil) {
            LabelPassword.text = "**********"
            passwordIsVisible = false;
        }
        
        
        
        LabelEmail.text = SelectedPassword?.mail;
        LabelUsername.text = SelectedPassword?.username;
        
        
        
        if(LabelDescription.text == "" || LabelDescription.text == nil) {
            LabelDescription.text = "Keine Beschreibung";
        }
        if(LabelPassword.text == "" || LabelPassword.text == nil) {
            LabelPassword.text = "Kein Passwort";
        }
        if(LabelEmail.text == "" || LabelEmail.text == nil)  {
            LabelEmail.text = "Keine Email";
        }
        if(LabelUsername.text == ""  || LabelUsername.text == nil) {
            LabelUsername.text = "Kein Benutzername";
        }
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd.MM.YYYY hh:mm";
        let addedString = dateFormatter.string(from: SelectedPassword?.createDate as! Date)
        let editedString = dateFormatter.string(from: SelectedPassword?.createDate as! Date)
        
        LabelAdded.text = "Hinzugefügt am \(addedString)";
        LabelEdited.text = "Bearbeitet am \(editedString)";
    }
    
    
    @IBAction func ButtonShowPasswordClick(_ sender: UIButton) {
        if(passwordIsVisible)! {
            LabelPassword.text = "**********"
            passwordIsVisible = false;
        } else {
            LabelPassword.text = SelectedPassword?.password;
            passwordIsVisible = true;
        }
    }
    
    @IBAction func ButtonCopyPasswordClick(_ sender: UIButton) {
        UIPasteboard.general.string = SelectedPassword?.password;
    }
  
    
    @IBAction func ButtonEditClick(_ sender: Any) {
       

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let newController = storyBoard.instantiateViewController(withIdentifier: "EditPasswordController");
        
        // get the nav controller
        let navController = newController as! UINavigationController;
        // get the view controller from the nav controller
        let viewController = navController.topViewController as!EditPasswordController;
        viewController.SelectedPassword = SelectedPassword;
        navigationController?.pushViewController(viewController, animated: true)

    }
    
}
