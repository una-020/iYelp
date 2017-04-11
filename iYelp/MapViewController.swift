//
//  MapViewController.swift
//  iYelp
//
//  Created by Anusha Kopparam on 4/9/17.
//  Copyright © 2017 Anusha Kopparam. All rights reserved.
//

import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var businessToPlot: [Business] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
            let center = CLLocationCoordinate2D(
            latitude: 37.785771,
            longitude: -122.406165 )
        
            let span = MKCoordinateSpanMake(0.05, 0.05)
            self.mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: false)
        
            plot()
}
    
    func plot(){
        if businessToPlot.count != 0 {
            for business in businessToPlot {
                let annotation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: business.latitude!, longitude: business.longitude!)
                annotation.coordinate = coordinate
                annotation.title = business.name
                annotation.subtitle = business.categories
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.dismiss(animated: true, completion: nil)
    }

}
