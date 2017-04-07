//
//  BusinessesViewController.swift
//  iYelp
//
//  Created by Badhri Jagan Sridharan on 4/6/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {
    @IBOutlet weak var searchNavigationBar: UINavigationItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var searchResultTable: UITableView!
    

//    @IBOutlet weak var businessBarSearchBar: UISearchBar!

    var businessBarSearchBar: UISearchBar = UISearchBar()
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        businessBarSearchBar.placeholder = "Restaurants"
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
         
        }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
       searchNavigationBar.titleView = businessBarSearchBar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
