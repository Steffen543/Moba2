//
//  ShowPasswordController.swift
//  password-manager
//
//  Created by sk-153353 on 07.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit;

class EditPasswordController : UIViewController{
    
    public var SelectedPassword : Password?;
    @IBOutlet weak var TextFieldName: UITextField!
    @IBOutlet weak var TextFieldEmail: UITextField!
    @IBOutlet weak var LabelAdded: UILabel!
    @IBOutlet weak var TextFieldDescription: UITextView!
    @IBOutlet weak var TextFieldUsername: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!
    @IBOutlet weak var LabelEdited: UILabel!
    @IBOutlet weak var ButtonShowPassword: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = SelectedPassword?.name;
        
        
        TextFieldName.text = SelectedPassword?.name;
        TextFieldEmail.text = SelectedPassword?.mail;
        TextFieldPassword.text = SelectedPassword?.password;
        TextFieldUsername.text = SelectedPassword?.username;
        TextFieldDescription.text = SelectedPassword?.descriptionText;
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd.MM.YYYY hh:mm";
        let addedString = dateFormatter.string(from: SelectedPassword?.createDate as! Date)
        let editedString = dateFormatter.string(from: SelectedPassword?.createDate as! Date)
        
        LabelAdded.text = "Hinzugefügt am \(addedString)";
        LabelEdited.text = "Bearbeitet am \(editedString)";
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let newName = TextFieldName.text;
        
        if (newName?.isEmpty)! {
            print("new name is empty, password will not be saved")
            return;
        }
        
        SelectedPassword?.name = TextFieldName.text;
        SelectedPassword?.mail = TextFieldEmail.text;
        SelectedPassword?.username = TextFieldUsername.text;
        SelectedPassword?.password = TextFieldPassword.text;
        SelectedPassword?.descriptionText = TextFieldDescription.text;
        SelectedPassword?.editDate = NSDate();
        
        let Manager = DBPasswordManager();

        Manager.save(password: SelectedPassword!)
    }
    
    
    @IBAction func showPasswordButtonClicked(_ sender: Any) {
        if (TextFieldPassword.isSecureTextEntry) {
            TextFieldPassword.isSecureTextEntry = false;
            ButtonShowPassword.setTitle("Verbergen", for: .normal)
        } else {
            TextFieldPassword.isSecureTextEntry = true;
            ButtonShowPassword.setTitle("Anzeigen", for: .normal)

        }
    }
    
    @IBAction func copyPasswordButtonClicked(_ sender: Any) {
        UIPasteboard.general.string = TextFieldPassword.text;
    }
    
    @IBAction func generatePasswordButtonClicked(_ sender: Any) {
    }
    
    
}
