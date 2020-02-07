//
//  WishlistCustomTableViewCell.swift
//  TheHoneymoonPlanner
//
//  Created by Jerry haaser on 2/3/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreData

class WishlistCustomTableViewCell: UITableViewCell {
    
//    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    
    @IBOutlet weak var wishlistItemLabel: UILabel!

    @IBAction func wishlistChecked(_ sender: UISwitch) {
        
    }
    
    var wishlist: Wishlist? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        
        guard let wishlist = wishlist else { return }
        
        wishlistItemLabel.text = wishlist.item
    }
    

}
