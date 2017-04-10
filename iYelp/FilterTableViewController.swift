//
//  FilterTableViewController.swift
//  iYelp
//
//  Created by Anusha Kopparam on 4/6/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController, CategoryCellDelegate, OfferCellDelegate {
  
    @IBOutlet var filterTable: UITableView!
    var searchApplied: Bool = false
    var newFilter: filter = filter()

    var opened: Bool = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.filterTable.delegate = self
        self.filterTable.dataSource = self
        distanceShowing = false
        sortShowing = false
        
        newFilter.offeringDeal = currentFilter.offeringDeal
        newFilter.distance = currentFilter.distance
        newFilter.sortBy = currentFilter.sortBy
        newFilter.category = currentFilter.category.map({$0})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 1){
            return "Distance"
        }
        if(section == 2){
            return "Sort By"
        }
        if(section == 3){
            return "Category"
        }
        return ""
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        
        if(section == 1){
            if(distanceShowing==false){
                return 1
            }
            return distancesText.count
        }
        
        if(section == 2){
            if(sortShowing==false){
                return 1
            }
            return sortByText.count
        }
        
        if(section == 3){
            if opened==false{
                return 4 }
            return categories.count
        }
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "OfferDealCell", for: indexPath) as! OfferDealCell
            cell.offerDelegate = self
            cell.offersSwitch.isOn = currentFilter.offeringDeal
            return cell
        }
        
        if (indexPath.section == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceCell", for: indexPath) as! DistanceCell
            cell.selectionStyle = UITableViewCellSelectionStyle.blue
            cell.accessoryType = UITableViewCellAccessoryType.none

            if (distanceShowing==false){
                cell.distanceLabel.text = distancesText[distanceSelected]
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

            }
            else {
                cell.distanceLabel.text = distancesText[indexPath.row]
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            return cell
        }
        
        if (indexPath.section == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SortByCell", for: indexPath) as! SortByCell
            cell.selectionStyle = UITableViewCellSelectionStyle.blue
            cell.accessoryType = UITableViewCellAccessoryType.none
            if(sortShowing==false){
                    cell.sortByLabel.text = sortByText[sortBySelected]
                    cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

            }
            else{
                cell.sortByLabel.text = sortByText[indexPath.row]
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            return cell
        }
        
        if (indexPath.section == 3){
            if opened==false && indexPath.row==3{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SeeMoreCell", for: indexPath)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.categoryDelegate = self
            cell.categoryLabel.text = categories[indexPath.row]["name"]
            if currentFilter.category.index(of: cell.categoryLabel.text!) != nil{
                cell.categorySwitch.isOn = true
            }
            else{
                cell.categorySwitch.isOn = false
            }
            return cell
        }
        let cell = UITableViewCell()
        cell.textLabel?.text = "Section >3"
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if(indexPath.section==1){
            distanceSelected = indexPath.row
            distanceShowing = !distanceShowing
            tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableViewRowAnimation.bottom)
        }
        if(indexPath.section==2){
            sortBySelected = indexPath.row
            sortShowing = !sortShowing
            tableView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: UITableViewRowAnimation.bottom)
        }
        if(indexPath.section==3){
            print(indexPath.row)
            if indexPath.row<2{
                opened = false
            }
            else{
                opened = true
                tableView.reloadData()
            }
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        let button: UIBarButtonItem = sender as! UIBarButtonItem
        
        if(button.title == "Search"){
            searchApplied = true
        }
        else {
            searchApplied = false
        }
    }
    
    func categoryCellDidToggle(cell: CategoryCell, isSelected: Bool, categoryName: String) {
        if(isSelected == true){
            newFilter.category.append(categoryName)
            isCategorySelected[categoryName] = isSelected
        }
        else{
            newFilter.category = newFilter.category.filter({$0 != categoryName})
            isCategorySelected[categoryName] = isSelected
        }
    }

    func offerCellToggle(cell: OfferDealCell, isSelected: Bool) {
        newFilter.offeringDeal = isSelected
    }
}
