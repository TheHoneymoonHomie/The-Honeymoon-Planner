//
//  Wishlist+Convenience.swift
//  TheHoneymoonPlanner
//
//  Created by Jerry haaser on 2/3/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import Foundation
import CoreData

extension Wishlist {
    
    @discardableResult convenience init(item: String?, isSelected: Bool = false, context: NSManagedObjectContext) {
    
        self.init(context: context)
        self.item = item
        self.isSelected = isSelected
        
        
    }
}
