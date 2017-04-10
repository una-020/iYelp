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

class BusinessesViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var searchNavigationBar: UINavigationItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var searchResultTable: UITableView!
   
    var businessBarSearchBar: UISearchBar = UISearchBar()
    var businesses: [Business] = []
    var searchActive:Bool = false
    
    var filtered:[Business] = []
    var selectedBusiness: Business!
    var categoriesSelected: [String] = []
    
    let locationManager = CLLocationManager()

    
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
            
            if let businesses = businesses {
                self.businesses = businesses
            }
            self.searchResultTable.reloadData()
        })

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        businessBarSearchBar.text = "Restaurants"
        businessBarSearchBar.placeholder = "Restaurants"
        searchResultTable.delegate = self
        searchResultTable.dataSource = self
        businessBarSearchBar.delegate = self
        
        searchResultTable.estimatedRowHeight = 110
        searchResultTable.rowHeight  = UITableViewAutomaticDimension
        searchResultTable.showsInfiniteScrolling = false
        

        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
        
        searchResultTable.addPullToRefresh{Business.searchWithTerm(term: "Restaurants", sort: YelpSortMode(rawValue: currentFilter.sortBy), categories: self.categoriesSelected, deals: currentFilter.offeringDeal, distance: currentFilter.distance, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            if let businesses = businesses {
                self.businesses = businesses
            }
            self.searchResultTable.reloadData()
            })}


        for i in 0..<categories.count {
            if currentFilter.category.index(of: categories[i]["name"]!) != nil {
                categoriesSelected.append(categories[i]["code"]!)
            }
        }
        
        print(categoriesSelected)

        Business.searchWithTerm(term: "Restaurants", sort: YelpSortMode(rawValue: currentFilter.sortBy), categories: categoriesSelected, deals: currentFilter.offeringDeal, distance: currentFilter.distance, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                        if let businesses = businesses {
                            self.businesses = businesses
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

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedBusiness = businesses[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navController = segue.destination as! UINavigationController
        if segue.identifier == "ShowMaps" {
            let mapsVC = navController.topViewController as! MapViewController
            mapsVC.businessToPlot = businesses
        }
        
        if segue.identifier == "ShowDetails"{
            let detailsVC = navController.topViewController as! DetailsViewController
            detailsVC.detailsBusiness = selectedBusiness
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
