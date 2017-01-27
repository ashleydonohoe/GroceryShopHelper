//
//  GooglePlacesAPIClient.swift
//  GroceryShopHelper
//
//  Created by Ashley Donohoe on 1/19/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import Foundation
import UIKit

class GooglePlacesAPIClient: NSObject {
    
    var stores = [Store]()
    var userLatitude:Double?
    var userLongitude: Double?
    
    //Allows client to act as singleton
    class func sharedInstance() -> GooglePlacesAPIClient {
        struct Singleton {
            static var sharedInstance = GooglePlacesAPIClient()
        }
        return Singleton.sharedInstance
    }
    
    // Network call to get store data based on user preference and location
    func getListOfStores(completionHandlerForStores: @escaping (_ success: Bool, _ error: String) -> Void) {
        // Method parameters
        let methodParameters:[String:Any] = [
            Constants.ParameterKeys.APIKey: Constants.ParameterValues.APIKey,
            Constants.ParameterKeys.Query: Constants.ParameterValues.QueryItem,
            Constants.ParameterKeys.Radius: UserDefaults.standard.value(forKey: "maxStoreDistance") as! Int,
            Constants.ParameterKeys.OpenStatus: Constants.ParameterValues.OpenStatus,
            Constants.ParameterKeys.Location: Constants.ParameterValues.Coordinates
        ]
        
    
        // Creating URL and request
        let urlString = Constants.GooglePlacesAPI.BaseListURL + escapedParameters(parameters: methodParameters as [String : AnyObject])
        
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        // Data task to run
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // if an error occurs, print it. An error in completing this process will result in an alert on the Nearby Stores view 
            func displayError(_ error: String) {
                print(error)
                print("URL at time of error: \(url)")
                completionHandlerForStores(false, error)
            }
            
            guard (error == nil) else {
                displayError("There was an error: \(error)")
                return
            }
            
            // Did the response come back as 2xx?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            // Check if any data was returned
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            // Parse the data to JSON
            let parsedResult:[String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                displayError("Could not parse the data as JSON")
                return
            }            
            
            // Did Google return an error?
            guard let stat = parsedResult[Constants.ResponseKeys.Status] as? String, stat == Constants.ResponseValues.OKStatus else {
                displayError("The Google Maps API returned an error.")
                return
            }
            
            // Was the "results" key present?
            guard let storesDictionary = parsedResult[Constants.ResponseKeys.Results] as? [[String: AnyObject]] else {
                displayError("Could not find a key for 'results'")
                return
            }
            
            
            self.stores = Store.storesFromResults(results: storesDictionary)
            
            // Considered success if at least 1 store is returned; else, no stores could be returned
            if self.stores.count > 0 {
                completionHandlerForStores(true, "No stores returned")
            }
        }
        task.resume()
    }

    // Function for escaping parameters, repurposed from SleepingInTheLibrary
    private func escapedParameters(parameters: [String: AnyObject]) -> String {
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            
            for(key, value) in parameters {
                // Make sure that value is string
                let stringValue = "\(value)"
                
                // escape value
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
                // append it
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
            }
            
            // join into string
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }

    
}
