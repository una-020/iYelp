//
//  CategoryCell.swift
//  iYelp
//
//  Created by Anusha Kopparam on 4/7/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate: class {
    func categoryCellDidToggle(cell: CategoryCell, isSelected: Bool, categoryName:String)
}

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categorySwitch: UISwitch!
    
    weak var categoryDelegate: CategoryCellDelegate?
    
    @IBAction func categoryAction(_ sender: Any) {

        categoryDelegate?.categoryCellDidToggle(cell: self,isSelected: categorySwitch.isOn,categoryName: categoryLabel.text!)
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
