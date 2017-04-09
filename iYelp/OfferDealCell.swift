//
//  OfferDealCell.swift
//  iYelp
//
//  Created by Anusha Kopparam on 4/7/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit

protocol OfferCellDelegate: class {
    func offerCellToggle(cell: OfferDealCell, isSelected: Bool)
}

class OfferDealCell: UITableViewCell {
    @IBOutlet weak var offersSwitch: UISwitch!
    
    weak var offerDelegate: OfferCellDelegate?
    
    @IBAction func offerAction(_ sender: Any) {
        offerDelegate?.offerCellToggle(cell: self, isSelected: offersSwitch.isOn)
        //          newFilter.offeringDeal = offersSwitch.isOn
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
