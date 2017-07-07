//
//  ShowPasswordController.swift
//  password-manager
//
//  Created by sk-153353 on 07.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit;

class ShowPasswordController : UITableViewController{
    
    public var SelectedPassword : Password?;

    override func viewDidLoad() {
        super.viewDidLoad()
        title = SelectedPassword?.name;
        let Manager = DBPasswordManager();
       
    }
    
    
}
