//
//  EditFolderViewController.swift
//  password-manager
//
//  Created by sk-153353 on 11.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit;

class EditFolderViewController : UIViewController{

    public var SelectedFolder : Category?;
    @IBOutlet var TextFieldName: UITextField!
    @IBOutlet var TextFieldDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = SelectedFolder?.name;
        TextFieldName.text = SelectedFolder?.name;
        TextFieldDescription.text = SelectedFolder?.descriptionText;
        
    }

    @IBAction func SaveFolderButtonClicked(_ sender: Any) {
        let newName = TextFieldName.text;
        
        if (newName?.isEmpty)! {
            print("new name is empty, password will not be saved")
            return;
        }
        
        SelectedFolder?.name = newName;
        SelectedFolder?.descriptionText = TextFieldDescription.text;
        
        let Manager = DBCategoryManager();
        
        Manager.save(category: SelectedFolder!);
        
        
    }
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    @IBAction func ButtonDeleteFolderClicked(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Bestätigen", message: "Eintrag wirklich löschen?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ja", style: .default, handler: { (action: UIAlertAction!) in
            
            let Manager = DBCategoryManager();
            print("deleting category with id \(self.SelectedFolder?.id)");
            Manager.delete(category: self.SelectedFolder!);
            self.backTwo();
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        present(refreshAlert, animated: true, completion: nil)

    }
    
    
    
    
    
}
