//
//  StoreDetailsViewController.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit
import MapKit

class StoreDetailsViewController: UIViewController {
    
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
