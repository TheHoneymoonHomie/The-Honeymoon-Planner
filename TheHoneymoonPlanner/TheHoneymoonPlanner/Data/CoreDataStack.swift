//
//  CoreDataStack.swift
//  TheHoneymoonPlanner
//
//  Created by Brandi Bailey on 2/2/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//


import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()

    private init() {}

    /// A generic function to save any context we want (main or background)
    func save(context: NSManagedObjectContext) throws {
        //Placeholder in case something doesn't work
        var closureError: Error?

        context.performAndWait {
            do {
                try context.save()
                print("SAVED!!!")
            } catch {
                NSLog("error saving moc: \(error)")
                closureError = error
            }
        }
        if let error = closureError {
            throw error
        }
    }

    /// Access to the Persistent Container
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TheHoneymoonPlanner")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error {
                fatalError("Failed to load persistent store: \(error)")
            }
        })
        // May need to be disabled if dataset is too large for performance reasons
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}

extension NSManagedObjectContext {
    static let context = CoreDataStack.shared.mainContext
}
