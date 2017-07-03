//
//  Password+CoreDataProperties.swift
//  password-manager
//
//  Created by ed-153020 on 03.07.17.
//  Copyright © 2017 sk-ed. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Password {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Password> {
        return NSFetchRequest<Password>(entityName: "Password");
    }

    @NSManaged public var createDate: NSDate?
    @NSManaged public var descriptionText: String?
    @NSManaged public var editDate: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var mail: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}
