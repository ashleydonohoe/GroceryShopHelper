//
//  StoreDetailsViewController.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StoreDetailsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var store: Store?
    var lat:CLLocationDegrees?
    var lng:CLLocationDegrees?
    let googleMapsAPI = GooglePlacesAPIClient.sharedInstance()
    

    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeAddressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var storeMapView: MKMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let store = store {
            showStoreDetails(store: store)
            
            // sets up the mapview with annotation for store
            let location = store.storeGeometry["location"] as! [String:Any]
            lat = CLLocationDegrees(location["lat"] as! Double)
            lng = CLLocationDegrees(location["lng"] as! Double)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
            storeMapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpanMake(0.01, 0.01)), animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = store.storeName
            annotation.subtitle = "Tap for Directions"
            
            self.storeMapView.addAnnotation(annotation)
        }
    }

    // Adds store detail info
    func showStoreDetails(store: Store) {
        storeNameLabel.text = store.storeName
        storeAddressLabel.text = store.storeAddress
        let storeRatingNumber = Int(store.storeRating.rounded())
        ratingLabel.text = getStarRating(rating: storeRatingNumber)
        priceRangeLabel.text = getPriceRange(price: store.storePriceLevel)
    }
    
    
    // Returns price range string
    func getPriceRange(price: Int) -> String {
        switch price {
        case 1:
            return "Inexpensive"
        case 2:
            return "Moderate"
        case 3:
            return "Expensive"
        case 4:
            return "Very Expensive"
        default:
            return "Not Available"
        }
    }
    
    // Creates text for star rating based on rating rounded to nearest Int
    func getStarRating(rating: Int) -> String {
        if rating == 0 {
            return "Not Rated"
        }
        return String(repeating: "⭐️", count: rating)
    }
    
    // Code to add accessory view for pin and allow call out, adapted from PinSample app from iOS networking course
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = storeMapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    
   // Allows the annotation to respond to a tap and for the user to be able to open the Maps app for directions
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            let toOpen = URL(string: "http://maps.apple.com/?saddr=\(googleMapsAPI.userLatitude!),\((googleMapsAPI.userLongitude!))&daddr=\(lat!),\(lng!)")
            app.open(toOpen!, options: [:], completionHandler: nil)
        }
    }
}
