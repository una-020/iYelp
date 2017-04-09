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
        
//        print("category \(categoryLabel.text!): \(categorySwitch.isOn)")
//        if(categorySwitch.isOn == true){
//                newFilter.category.append(categoryLabel.text!)
//                isCategorySelected[categoryLabel.text!] = true
//        }
//        else{
//            newFilter.category = newFilter.category.filter({$0 != categoryLabel.text})
//            isCategorySelected[categoryLabel.text!] = false
//        }
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
