//
//  DBCategoryManager.swift
//  password-manager
//
//  Created by ed-153020 on 04/07/2017.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import UIKit
import CoreData


class DBCategoryManager
{
    //context with is responsible for the database
    //String(describing: MyViewController.self)
    var ManagedContext: NSManagedObjectContext;
    
    
    //Initialises the password manager
    init()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        ManagedContext = appDelegate.persistentContainer.viewContext;
    }
    
    
    //returns a new category instance which can be edited and saved
    public func getNewObject() -> Category
    {
        var newCategory: Category?;
        
        do
        {
            var fetchResult: [Category] = []
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category");
            fetchResult = try ManagedContext.fetch(fetchRequest) as! [Category]
            
            newCategory = Category(context: ManagedContext);
            newCategory!.id = fetchResult.count + 1
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
        return newCategory!
    }
    
    //saves a given category object in the database. handles update and create
    public func save(category: Category)
    {
        do
        {
            try ManagedContext.save();
        }
        catch let error as NSError
        {
            print("Could not save. \(error), \(error.userInfo)");
        }
    }
    
    // returns a existing category from the database by the given id
    func load(categoryId: Int32) -> Category
    {
        var result: Category?;
        
        do
        {
            var fetchResult: [Category] = [];
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category");
            fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: categoryId));
            fetchRequest.fetchLimit = 1;
            
            fetchResult = try ManagedContext.fetch(fetchRequest) as! [Category];
            result = fetchResult.first;
            
            //get password count
            if (result != nil)
            {
                let manager = DBPasswordManager();
                let passwords = manager.load(categoryId: result!.id);
                result!.passwordCount = Int32(passwords.count);
            }
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)");
            
        }
        
        return result!
    }
    
    //returns all passwords in a given category
    func loadAll() -> [Category]
    {
        var fetchResult: [Category] = []
        
        do
        {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category");
            fetchResult = try ManagedContext.fetch(fetchRequest) as! [Category];
            
            //get the password count for each category
            let manager = DBPasswordManager();
            for loadedCategory in fetchResult
            {
                let passwords = manager.load(categoryId: loadedCategory.id);
                loadedCategory.passwordCount = Int32(passwords.count);
            }
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)");
        }
        
        return fetchResult;
    }
    
    //removes a category and all included passwords from the database
    func delete(category: Category) {
        let PWManager = DBPasswordManager();
        let passwords = PWManager.load(categoryId: category.id);
        
        for pw in passwords {
            ManagedContext.delete(pw);
            PWManager.save(password: pw);
        }
        
        ManagedContext.delete(category);
        save(category: category);
    }
}


