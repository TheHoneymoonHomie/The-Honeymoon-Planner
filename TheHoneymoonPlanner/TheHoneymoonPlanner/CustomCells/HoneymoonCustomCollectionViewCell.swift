//
//  HoneymoonCustomCollectionViewCell.swift
//  TheHoneymoonPlanner
//
//  Created by Jerry haaser on 2/4/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit

class HoneymoonCustomCollectionViewCell: UICollectionViewCell {
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    var activty: Activity?
    var activities: [Activity] = []
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var vacationNameLabel: UILabel!
    @IBOutlet weak var wishlistLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
        override func prepareForReuse() {
            super.prepareForReuse()
            
            imageView.image = nil
            vacationNameLabel.text = ""
            wishlistLabel.text = ""
            priceLabel.text = ""
        }
        
        func updateViews() {
            
            guard activty != nil else { return }
        
            //TODO: change all this
            imageView.image = nil
            vacationNameLabel.text = ""
            wishlistLabel.text = "Wishlist Check Count"
            priceLabel.text = ""
        }

        
        func setImage(_ image: UIImage?) {
            imageView.image = image
        }

//        var post: Post? {
//            didSet {
//                updateViews()
//            }
//        }
}
