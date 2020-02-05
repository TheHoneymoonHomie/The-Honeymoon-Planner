//
//  Wishlist+CoreDataProperties.swift
//  TheHoneymoonPlanner
//
//  Created by Brandi Bailey on 2/4/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//
//

import Foundation
import CoreData


extension Wishlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wishlist> {
        return NSFetchRequest<Wishlist>(entityName: "Wishlist")
    }

    @NSManaged public var item: String?

}
