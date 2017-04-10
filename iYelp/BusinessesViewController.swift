//
//  BusinessesViewController.swift
//  iYelp
//
//  Created by Anusha Kopparam on 4/6/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit
import SVPullToRefresh
import MapKit

class BusinessesViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, MKMapViewDelegate {
    @IBOutlet weak var searchNavigationBar: UINavigationItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var searchResultTable: UITableView!
   
    var businessBarSearchBar: UISearchBar = UISearchBar()
    var businesses: [Business] = []
    var searchActive:Bool = false
    
    var filtered:[Business] = []

    var categoriesSelected: [String] = []
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        var toSearch: [String] = []
        toSearch.append(searchBar.text!.lowercased())
        print("searchBarSearchButtonClicked \(searchBar.text!)")
        Business.searchWithTerm(term: "Restaurants", sort: YelpSortMode(rawValue: currentFilter.sortBy), categories: toSearch, deals: currentFilter.offeringDeal, distance: currentFilter.distance, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses!
            if let businesses = businesses {
                for business in businesses {
                                                    print(business.name!)
                                                    print(business.longitude!)
                                                    print(business.latitude!)
                }
            }
            self.searchResultTable.reloadData()
        })

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        businessBarSearchBar.placeholder = "Restaurants"
        businessBarSearchBar.text = "Restaurants"
        searchResultTable.delegate = self
        searchResultTable.dataSource = self
        businessBarSearchBar.delegate = self
        
        searchResultTable.estimatedRowHeight = 110
        searchResultTable.rowHeight  = UITableViewAutomaticDimension
        searchResultTable.showsInfiniteScrolling = false

        for i in 0..<categories.count {
            if currentFilter.category.index(of: categories[i]["name"]!) != nil {
                categoriesSelected.append(categories[i]["code"]!)
            }
        }
        
        print(categoriesSelected)

        Business.searchWithTerm(term: "Restaurants", sort: YelpSortMode(rawValue: currentFilter.sortBy), categories: categoriesSelected, deals: currentFilter.offeringDeal, distance: currentFilter.distance, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                        self.businesses = businesses!
                        if let businesses = businesses {
                            for business in businesses {
//                                print(business.name!)
//                                print(business.address!)
//                                print(business.reviewCount!)
                            }
                        }
                        self.searchResultTable.reloadData()
                        
                    })
        
       searchNavigationBar.titleView = businessBarSearchBar
       searchResultTable.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive == true) {
            return filtered.count
        }
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "YelpTableViewCell") as! YelpTableViewCell
        
        var business: Business
        
        if (searchActive == true){
            business = filtered[indexPath.row]
        }
        else {
            business = businesses[indexPath.row]
        }
            cell.restaurantNameLabel.text = business.name
            cell.distanceLabel.text = business.distance
            let reviewCount: String! = String(describing: business.reviewCount!) + " Reviews"
            cell.reviewCountLabel.text! = reviewCount
            cell.addressLabel.text = business.address
            cell.CuisinesLabel.text = business.categories
            
            if let restaurantURL = business.imageURL {
                cell.restaurantImage.setImageWith(restaurantURL)
            }
            else{
                cell.restaurantImage = nil
            }
 
            if let ratingsURL = business.ratingImageURL {
                cell.ratingImage.setImageWith(ratingsURL)
            }
            else{
                cell.ratingImage = nil
            }
    
        return cell
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMaps" {
            let navController = segue.destination as! UINavigationController
            let mapsVC = navController.topViewController as! MapViewController
            mapsVC.businessToPlot = businesses
        }
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    
//     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////     if segue.identifier == "showPreferencesSegue" {
//     // we wrapped our PreferencesTableViewController inside a UINavigationController
//     let navController = segue.destinationViewController as UINavigationController
//     let prefsVC = navController.topViewController as PreferencesTableViewController
//     prefsVC.currentPrefs = self.preferences
//     }
//     }
//    
    
//    addPullToRefreshWithActionHandler
//    tableViewAddPull
}
