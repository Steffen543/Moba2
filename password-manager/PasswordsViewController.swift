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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = SelectedFolder?.name;
        
    }
    
    
    
}
