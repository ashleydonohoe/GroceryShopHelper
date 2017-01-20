//
//  Store.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import Foundation

struct Store {

    // Store properties
    let placeID:String // Google Maps place id for store
    let storeName:String
    let storeAddress:String
    let storePriceLevel: Int
    let storeRating:Double
    let storeGeometry: [String:Any]
    
    // Initializing store from dictionary
    init(dictionary: [String:Any]) {
        placeID = dictionary[Constants.ResponseKeys.PlaceID] as? String ?? "N/A"
        storeName = dictionary[Constants.ResponseKeys.PlaceName] as? String ?? "Store Name Unavailable"
        storeAddress = dictionary[Constants.ResponseKeys.Address] as? String ?? "Address not available"
        storePriceLevel = dictionary[Constants.ResponseKeys.PriceLevel] as? Int ?? 0
        storeRating = dictionary[Constants.ResponseKeys.Rating] as? Double ?? 0.0
        storeGeometry = dictionary[Constants.ResponseKeys.Geometry] as? [String: Any] ?? [:]
    }
    
    // Creating stores from the results
    static func storesFromResults(results: [[String:AnyObject]]) -> [Store] {
        var stores = [Store]()
        
        for result in results {
            stores.append(Store(dictionary: result))
        }
        
        return stores
    }
}
