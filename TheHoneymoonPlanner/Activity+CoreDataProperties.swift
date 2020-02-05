//
//  Activity+CoreDataProperties.swift
//  TheHoneymoonPlanner
//
//  Created by Brandi Bailey on 2/4/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var act_cost: Double
    @NSManaged public var act_date_end: Date?
    @NSManaged public var act_date_start: Date?
    @NSManaged public var act_latitude: Double
    @NSManaged public var act_longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var vacation: Activity?

}
