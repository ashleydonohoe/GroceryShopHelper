//
//  Constants.swift
//  ShoppingHelper
//
//  Created by Gabriele on 1/19/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import Foundation

struct Constants {
    struct GooglePlacesAPI {
        static let BaseListURL = "https://maps.googleapis.com/maps/api/place/textsearch/json"
        static let BaseDetailsURL = "https://maps.googleapis.com/maps/api/place/details/json"
    }
    
    struct ParameterKeys {
        static let APIKey = "key"
        static let Query = "query"
        static let Location = "location"
        static let Radius = "radius"
        static let OpenStatus = "opennow"
        static let LocationType = "type"
        
    }
    
    struct ParameterValues {
        static let APIKey = "AIzaSyB4ctVh8PHfqi5CCy3CDBR-mtnMQfbkV8s"
        static let LocationType = "grocery_or_supermarket"
        static let OpenStatus = true
        static let QueryItem = "grocery+stores"
        static let Coordinates = "\(GooglePlacesAPIClient.sharedInstance().userLatitude!), \(GooglePlacesAPIClient.sharedInstance().userLongitude!)"

    }
    
    struct ResponseKeys {
        static let Results = "results"
        static let PlaceName = "name"
        static let Address = "formatted_address"
        static let PlaceID = "place_id"
        static let Rating = "rating"
        static let PriceLevel = "price_level"
        static let Status = "status"
        static let Geometry = "geometry"
        static let Location = "location"
        static let Latitude = "lat"
        static let Longitude = "lng"
        
    }
    
    struct ResponseValues {
        static let OKStatus = "OK"
    }
}
