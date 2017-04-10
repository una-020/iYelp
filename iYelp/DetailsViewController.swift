//
//  DetailsViewController.swift
//  iYelp
//
//  Created by Anusha Kopparam on 4/9/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var detailsMap: MKMapView!
    @IBOutlet weak var detailsImage: UIImageView!
    
    @IBOutlet weak var detailsName: UILabel!
    @IBOutlet weak var detailsReview: UILabel!
    @IBOutlet weak var detailsAddress: UILabel!
    @IBOutlet weak var detailsRating: UIImageView!
    @IBOutlet weak var detailsURL: UILabel!
    @IBOutlet weak var detailsCuisine: UILabel!
    @IBOutlet weak var detailsPhone: UILabel!
    
    var detailsBusiness: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let center = CLLocationCoordinate2D(
            latitude: 37.785771,
            longitude: -122.406165 )
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        self.detailsMap.setRegion(MKCoordinateRegion(center: center, span: span), animated: false)
    

        if detailsBusiness != nil {
            if detailsBusiness.imageURL != nil {
                detailsImage.setImageWith(detailsBusiness.imageURL!)
            }
            else {
                detailsImage.image = nil
            }
            
            detailsName.text = detailsBusiness.name
            detailsReview.text = String(describing: detailsBusiness.reviewCount!) + " Reviews"
            detailsAddress.text = detailsBusiness.address
            if detailsBusiness.ratingImageURL != nil{
                    detailsRating.setImageWith(detailsBusiness.ratingImageURL!)
            }
            else{
                detailsRating.image = nil
            }
            
            detailsURL.text = detailsBusiness.url
            detailsURL.numberOfLines = 2
            detailsCuisine.text = detailsBusiness.categories
            detailsPhone.text = detailsBusiness.phoneNumber

            let annotation = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2D(latitude: detailsBusiness.latitude!, longitude: detailsBusiness.longitude!)
            annotation.coordinate = coordinate
            annotation.title = detailsBusiness.name
            annotation.subtitle = detailsBusiness.categories
            self.detailsMap.addAnnotation(annotation)

        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
