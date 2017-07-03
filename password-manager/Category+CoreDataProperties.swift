//
//  Category+CoreDataProperties.swift
//  password-manager
//
//  Created by ed-153020 on 03.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var createDate: NSDate?
    @NSManaged public var descriptionText: String?
    @NSManaged public var editDate: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var category_to_password: NSSet?

}

// MARK: Generated accessors for category_to_password
extension Category {

    @objc(addCategory_to_passwordObject:)
    @NSManaged public func addToCategory_to_password(_ value: Password)

    @objc(removeCategory_to_passwordObject:)
    @NSManaged public func removeFromCategory_to_password(_ value: Password)

    @objc(addCategory_to_password:)
    @NSManaged public func addToCategory_to_password(_ values: NSSet)

    @objc(removeCategory_to_password:)
    @NSManaged public func removeFromCategory_to_password(_ values: NSSet)

}
