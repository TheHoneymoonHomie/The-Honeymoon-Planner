//
//  VacationController.swift
//  TheHoneymoonPlanner
//
//  Created by Jerry haaser on 2/7/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class VacationController {
    
    static let shared = VacationController()
    
    func createVacation(with cost: Double?, date_start: Date?, date_end: Date?, imageURL: URL?, latitude: Double?, longitude: Double?, location: String?, title: String, wishlist: [Wishlist]? = [], activities: [Activity]? = [], context: NSManagedObjectContext) {
        
        Vacation(cost: cost, date_start: date_start, date_end: date_end, imageURL: imageURL, latitude: latitude, longitude: longitude, location: location, title: title, context: context)
        
        saveToPersistentStore()
    }
    
    func update(_ vacation: Vacation, with cost: Double?, date_start: Date?, date_end: Date?, imageURL: URL?, latitude: Double?, longitude: Double?, location: String?, title: String, wishlist: [Wishlist]? = [], activities: [Activity]? = [], context: NSManagedObjectContext) {
        
        vacation.date_start = date_start
        vacation.date_end = date_end
        vacation.imageURL = imageURL
        vacation.title = title
        vacation.location = location
        
        if let cost = cost,
            let latitude = latitude,
            let longitude = longitude,
            let wishlist = wishlist,
            let activities = activities {
            vacation.cost = cost
            vacation.latitude = latitude
            vacation.longitude = longitude
            vacation.wishlist = NSOrderedSet(array: wishlist)
            vacation.activities = NSOrderedSet(array: activities)
            
            saveToPersistentStore()
        }
    }
    
    func delete(_ vacation: Vacation) {
        
        let moc = NSManagedObjectContext.context
        moc.delete(vacation)
        
        saveToPersistentStore()
    }
    
    func loadVacationFromPersistentStore() -> [Vacation] {
        let fetchRequest: NSFetchRequest<Vacation> = Vacation.fetchRequest()
        let moc = NSManagedObjectContext.context
        
        do {
            let wishlist = try moc.fetch(fetchRequest)
            return wishlist
        } catch {
            NSLog("Error fetching vacation: \(error)")
            return []
        }
    }
    
    func saveToPersistentStore() {
        let moc = NSManagedObjectContext.context
        
        do {
            try moc.save()
        } catch {
            NSLog("Error saving from vacaton controller: \(error)")
            moc.reset()
        }
    }
    
}

