//
//  StoreDetailsViewController.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit
import MapKit

class StoreDetailsViewController: UIViewController, MKMapViewDelegate {
    
    var store: Store?

    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeAddressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var storeMapView: MKMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let store = store {
            showStoreDetails(store: store)
            let location = store.storeGeometry["location"] as! [String:Any]
            let lat = CLLocationDegrees(location["lat"] as! Double)
            let lng = CLLocationDegrees(location["lng"] as! Double)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            storeMapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpanMake(0.01, 0.01)), animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = store.storeName
            
            self.storeMapView.addAnnotation(annotation)
        }
    }

    // TODO: Add map and store details
    func showStoreDetails(store: Store) {
        storeNameLabel.text = store.storeName
        storeAddressLabel.text = store.storeAddress
        let storeRatingNumber = Int(store.storeRating.rounded())
        ratingLabel.text = getStarRating(rating: storeRatingNumber)
        priceRangeLabel.text = getPriceRange(price: store.storePriceLevel)
    }
    
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
    
    func getStarRating(rating: Int) -> String {
        if rating == 0 {
            return "Not Rated"
        }
        return String(repeating: "⭐️", count: rating)
    }
}
