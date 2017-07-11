//
//  DBPasswordManager.swift
//  password-manager
//
//  Created by ed-153020 on 04/07/2017.
//  Copyright © 2017 sk-ed. All rights reserved.
//

import UIKit
import CoreData


class DBPasswordManager
{
    //context with is responsible for the database
    var ManagedContext: NSManagedObjectContext;
    
    
    //Initialises the password manager
    init()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        ManagedContext = appDelegate.persistentContainer.viewContext;
    }
    
    
    //returns a new password instance which can be edited and saved
    public func getNewObject() -> Password
    {
        var newPassword: Password?;
        
        do
        {
            var fetchResult: [Password] = []
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Password");
            fetchResult = try ManagedContext.fetch(fetchRequest) as! [Password]
            
            newPassword = Password(context: ManagedContext);
            newPassword!.id = fetchResult.count + 1
            newPassword?.createDate = NSDate();
            newPassword?.editDate = NSDate();
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
        return newPassword!
    }
    
    //saves a given password object in the database. handles update and create
    public func save(password: Password)
    {
        do {
            
            //the password will now be saved in the keychain. the SQLite database ist not encrypted
            //let hashKey = String(password.id.hashValue);
            SecurityManager.setPasscode(identifier: String(password.id), passcode: password.password!);
            print("Saving password width ID\(password.id) and Password: \(password.password)");
            //password.password = String(password.id);
            password.editDate = NSDate();
            
            //persisting the password
            try ManagedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // returns a existing password from the database by the given id
    func load(passwordId: Int32) -> Password
    {
        var result: Password?
        
        do
        {
            var fetchResult: [Password] = []
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Password");
            fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: passwordId))
            fetchRequest.fetchLimit = 1
            
            fetchResult = try ManagedContext.fetch(fetchRequest) as! [Password]
            result = fetchResult.first
            result?.password = SecurityManager.getPasscode(identifier: String(passwordId))
            
            print("loading password width ID \(result?.id) and Password: \(result?.password)");

        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
        return result!
    }
    
    //returns all passwords in a given category
    func load(categoryId: Int32) -> [Password]
    {
        var fetchResult: [Password] = []
        
        do
        {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Password");
            fetchRequest.predicate = NSPredicate(format: "categoryId = %@", NSNumber(value: categoryId))
            
            fetchResult = try ManagedContext.fetch(fetchRequest) as! [Password]
            
            
            for pwd in fetchResult
            {
                pwd.password = SecurityManager.getPasscode(identifier: String(pwd.id))
            }
            
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
        return fetchResult
    }
    
    
    //removes a category and all included passwords from the database
    func delete(password: Password) {
        ManagedContext.delete(password);
    }
}


