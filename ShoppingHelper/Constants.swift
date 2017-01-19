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
        static let BaseListURL = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
        static let BaseDetailsURL = "https://maps.googleapis.com/maps/api/place/details/json?"
    }
    
    struct ParameterKeys {
        static let APIKey = "key"
        static let Query = "query"
        static let Location = "location"
        static let Radius = "radius"
        static let OpenStatus = "opennow"
        static let LocationType = "type"
        static let PlaceID = "placeid"
        
    }
    
    struct ParameterValues {
        static let LocationType = "grocery_or_supermarket"
        static let OpenStatus = true
    }
    
    struct ResponseKeys {
        static let Results = "results"
        static let PlaceName = "name"
        static let Address = "formatted_address"
        static let PlaceID = "place_id"
        static let Rating = "rating"
        static let PhoneNumber = "formatted_phone_number"
        static let Reviews = "reviews"
        static let Author_Name = "author_name"
        static let Review_Text = "text"
        
    }
    
    struct ResponseValues {
        static let OKStatus = "OK"
    }
}
