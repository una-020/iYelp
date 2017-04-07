//
//  YelpTableViewCell.swift
//  iYelp
//
//  Created by Badhri Jagan Sridharan on 4/6/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit

class YelpTableViewCell: UITableViewCell {
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var CuisinesLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
