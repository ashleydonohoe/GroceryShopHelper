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
    @IBOutlet weak var storeNumberControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
    }

    
    func loadSettings() {
        
    }
    
    @IBAction func saveSettings(_ sender: Any) {
        let maxDistance = Int(distanceControl.titleForSegment(at: distanceControl.selectedSegmentIndex)!)
        let maxStores = Int(storeNumberControl.titleForSegment(at: storeNumberControl.selectedSegmentIndex)!)
        
        print(maxDistance ?? 5, maxStores ?? 20)
    }
    

}
