//
//  Vacation+CoreDataProperties.swift
//  TheHoneymoonPlanner
//
//  Created by Brandi Bailey on 2/4/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//
//

import Foundation
import CoreData


extension Vacation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vacation> {
        return NSFetchRequest<Vacation>(entityName: "Vacation")
    }

    @NSManaged public var cost: Double
    @NSManaged public var date_end: Date?
    @NSManaged public var date_start: Date?
    @NSManaged public var imageURL: URL?
    @NSManaged public var latitude: Double
    @NSManaged public var location: String?
    @NSManaged public var longitude: Double
    @NSManaged public var title: String?
    @NSManaged public var activities: NSSet?

}

// MARK: Generated accessors for activities
extension Vacation {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Vacation)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Vacation)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}
