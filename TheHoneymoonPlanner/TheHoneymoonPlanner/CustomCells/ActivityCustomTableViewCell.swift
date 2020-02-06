//
//  ActivityCustomTableViewCell.swift
//  TheHoneymoonPlanner
//
//  Created by Jerry haaser on 2/3/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit

class ActivityCustomTableViewCell: UITableViewCell {

    var activity: Activity?
    var activities: [Activity] = []
    
    @IBOutlet weak var activityNameLable: UILabel!
    @IBOutlet weak var activityPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
