//
//  WishlistCustomTableViewCell.swift
//  TheHoneymoonPlanner
//
//  Created by Jerry haaser on 2/3/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit

class WishlistCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wishlistItemLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func wishlistChecked(_ sender: UISwitch) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
