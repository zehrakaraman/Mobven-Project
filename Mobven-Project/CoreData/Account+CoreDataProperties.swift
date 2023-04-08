//
//  Account+CoreDataProperties.swift
//  Mobven-Project
//
//  Created by Zehra on 4.04.2023.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var dateOfBirth: Date?
    @NSManaged var gender: String?

}

extension Account : Identifiable {

}
