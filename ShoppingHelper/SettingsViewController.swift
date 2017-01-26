//
//  SettingsViewController.swift
//  GroceryShopHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var distanceControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
    }

    // Loads the setting for the user's current distance. Conditional statement is used since Google Maps requires meters vs. miles
    func loadSettings() {
        let currentDistance = UserDefaults.standard.value(forKey: "maxStoreDistance") as! Int
        print(currentDistance)
        if currentDistance == 5000 {
            distanceControl.selectedSegmentIndex = 0
        } else if currentDistance == 8000 {
            distanceControl.selectedSegmentIndex = 1
        } else {
            distanceControl.selectedSegmentIndex = 2
        }
    }
    
    // Saves user's setting for distance.  Conditional statement is used since Google Maps requires meters vs. miles
    @IBAction func saveSettings(_ sender: Any) {
        let maxDistance = Int(distanceControl.titleForSegment(at: distanceControl.selectedSegmentIndex)!)
        
        var distanceInMeters = 0
        
        if maxDistance == 3 {
            distanceInMeters = 5000
        } else if maxDistance == 5 {
            distanceInMeters = 8000
        } else {
            distanceInMeters = 16000
        }
        
        UserDefaults.standard.set(distanceInMeters, forKey: "maxStoreDistance")
        UserDefaults.standard.synchronize()
        
       showAlert(title: "Success", message: "Updated settings")
    }
    
    // Shows the alert for settings being saved
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
