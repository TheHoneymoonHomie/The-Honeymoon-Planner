//
//  Vacation+Convenience.swift
//  TheHoneymoonPlanner
//
//  Created by Jerry haaser on 2/3/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import Foundation
import CoreData

extension Vacation {
    
    @discardableResult convenience init(cost: Double?, date_start: Date?, date_end: Date?, imageURL: URL?, latitude: Double?, longitude: Double?, location: String?, title: String, wishlist: [Wishlist]? = [], activities: [Activity]? = [], context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.date_start = date_start
        self.date_end = date_end
        self.imageURL = imageURL
        self.title = title
        self.location = location
        
        if let cost = cost,
            let latitude = latitude,
            let longitude = longitude,
            let wishlist = wishlist,
            let activities = activities {
            self.cost = cost
            self.latitude = latitude
            self.longitude = longitude
            self.wishlist = NSOrderedSet(array: wishlist)
            self.activities = NSOrderedSet(array: activities)
        }
    }
}

