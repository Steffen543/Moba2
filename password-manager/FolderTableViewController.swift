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
            cell.detailTextLabel?.text = "FILTER";

        } else {
            cell.textLabel?.text = Folders![indexPath.row].name;
            cell.detailTextLabel?.text = "TEST";

        }
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
        navigationItem.backBarButtonItem = backItem
   
    }
    
  

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedFolder = Folders?[indexPath.row];
        
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
        navigationItem.backBarButtonItem = backItem
        
        let destinationVC = PasswordsViewController()
        destinationVC.SelectedFolder = selectedFolder
        
        
        //destinationVC.performSegue(withIdentifier: "showPasswordsSegue", sender: self)
        navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    
}

extension FolderTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)

    }
}


