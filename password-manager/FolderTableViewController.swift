//
//  FolderTableViewController.swift
//  password-manager
//
//  Created by sk-153353 on 03.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit

class FolderTableViewController : UITableViewController{
    
    var folders = [ "Test", "Ordner", "Gay", "swift", "stinkt" ];
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath);
        cell.textLabel?.text = folders[indexPath.row];
        cell.detailTextLabel?.text = "TEST";
        return cell;
        
    }
    
}
