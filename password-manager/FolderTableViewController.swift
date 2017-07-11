//
//  FolderTableViewController.swift
//  password-manager
//
//  Created by sk-153353 on 03.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import Foundation
import UIKit


class FolderTableViewController : UITableViewController  {
    
    
    @IBOutlet weak var MainSearchBar: UISearchBar!
    @IBOutlet var MainTableView: UITableView!
    var Folders : [Category]?;
    var FoldersFiltered:[Category]?;
    let searchController = UISearchController(searchResultsController: nil);

    
    
    @IBAction func AddButtonClick(_ sender: Any) {
        let alert = UIAlertController(title: "Kategorie hinzufügen", message: "Geben Sie einen Namen ein", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
 
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let text = textField?.text;
            
            if text == "" { return; }
            
            let Manager = DBCategoryManager();
            let newCategory = Manager.getNewObject();
            
            newCategory.name = text;
            newCategory.createDate = NSDate();
            newCategory.editDate = NSDate();
            
            Manager.save(category: newCategory);
            
            self.Folders?.append(newCategory);
            self.MainTableView.reloadData();
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        let categoryManager = DBCategoryManager();
        Folders = categoryManager.loadAll();
        MainTableView.reloadData();
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        
        let categoryManager = DBCategoryManager();
        Folders = categoryManager.loadAll();
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        FoldersFiltered = Folders?.filter { folder in
            return folder.name?.lowercased().range(of: searchText.lowercased()) != nil
        }
        
        tableView.reloadData()
    }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searchController.isActive && searchController.searchBar.text != "" {
            return FoldersFiltered!.count
        }
        return Folders!.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath);

        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = FoldersFiltered![indexPath.row].name;
            cell.detailTextLabel?.text = String(FoldersFiltered![indexPath.row].passwordCount) + " Einträge";

        } else {
            cell.textLabel?.text = Folders![indexPath.row].name;
            cell.detailTextLabel?.text = String(Folders![indexPath.row].passwordCount) + " Einträge";

        }
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
        navigationItem.backBarButtonItem = backItem*/
   
    }
    
  

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedFolder = Folders?[indexPath.row];
        
        
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
        navigationItem.backBarButtonItem = backItem
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let newController = storyBoard.instantiateViewController(withIdentifier: "PasswordsViewController");

        // get the nav controller
        let navController = newController as! UINavigationController;
        // get the view controller from the nav controller
        let viewController = navController.topViewController as!PasswordsViewController;
        viewController.SelectedFolder = selectedFolder;
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
}

extension FolderTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)

    }
}


