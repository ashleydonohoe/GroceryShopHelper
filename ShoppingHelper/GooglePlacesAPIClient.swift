//
//  GooglePlacesAPIClient.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/19/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import Foundation

class GooglePlacesAPIClient: NSObject {
    
    //Allows client to act as singleton
    class func sharedInstance() -> GooglePlacesAPIClient {
        struct Singleton {
            static var sharedInstance = GooglePlacesAPIClient()
        }
        return Singleton.sharedInstance
    }
    
}
