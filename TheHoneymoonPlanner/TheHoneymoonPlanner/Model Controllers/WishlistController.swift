//
//  WishlistController.swift
//  TheHoneymoonPlanner
//
//  Created by Brandi Bailey on 2/6/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WishlistController {
    
    static let shared = WishlistController()
    
    func create(with itemName: String, context: NSManagedObjectContext = .context) {
        
        Wishlist(item: itemName, context: context)
        saveToPersistentStore()
    }
    
    func update(_ wishlist: Wishlist, with itemName: String, isSelected: Bool = false) {
        
        wishlist.item = itemName
        wishlist.isSelected = isSelected
        
        saveToPersistentStore()
    }
    
    func delete(_ whishlist: Wishlist) {
        
        let moc = NSManagedObjectContext.context
        moc.delete(whishlist)
        
        saveToPersistentStore()
    }
    
    func loadWishlistFromPersistentStore() -> [Wishlist] {
        let fetchRequest: NSFetchRequest<Wishlist> = Wishlist.fetchRequest()
        let moc = NSManagedObjectContext.context
        
        do {
            let wishlist = try moc.fetch(fetchRequest)
            return wishlist
        } catch {
            NSLog("Error fetching wishlist: \(error)")
            return []
        }
    }
    
    func saveToPersistentStore() {
        let moc = NSManagedObjectContext.context
        
        do {
            try moc.save()
        } catch {
            NSLog("Error saving main context: \(error)")
            moc.reset()
        }
    }
    
    
}
