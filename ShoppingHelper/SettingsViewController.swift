//
//  SettingsViewController.swift
//  ShoppingHelper
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
        
        print("Saving maxDistance: \(distanceInMeters)")
        
        UserDefaults.standard.set(distanceInMeters, forKey: "maxStoreDistance")
        UserDefaults.standard.synchronize()
    }
    
    
    

}
