//
//  StoresListViewController.swift
//  GroceryShopHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit
import CoreLocation

class StoresListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var storesTable: UITableView!
    
    let googleMapsAPI = GooglePlacesAPIClient.sharedInstance()
    var storesList = [Store]()
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity.isHidden = true
        
        
//        // Setting up location manager to get permission
//        locationManager = CLLocationManager()
//        locationManager?.delegate = self
//        locationManager?.requestWhenInUseAuthorization()
//        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager?.startUpdatingLocation()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Setting up location manager to get permission
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()

        
        if let location = locationManager?.location?.coordinate {
            googleMapsAPI.userLatitude = location.latitude
            googleMapsAPI.userLongitude = location.longitude
        }
        
        checkForLocation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell")!
        let store = storesList[indexPath.row]
        cell.textLabel?.text = store.storeName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "StoreDetailsViewController") as! StoreDetailsViewController
        controller.store = storesList[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // Obtains the store data from Google Maps API
    func getStoreData() {
        self.refreshButton.isEnabled = false
        activity.startAnimating()
        
        storesList = []
        
        googleMapsAPI.getListOfStores { (success, error) in
            if success {
                self.storesList = self.googleMapsAPI.stores
                
                performUIUpdatesOnMain {
                    self.activity.stopAnimating()
                    self.storesTable.reloadData()
                    self.refreshButton.isEnabled = true
                }
            } else {
                performUIUpdatesOnMain {
                    self.showAlert(title: "Error", message: error)
                    self.refreshButton.isEnabled = true
                    self.activity.stopAnimating()
                }
            }
        }
    }
    
    // Allows user to refresh stores
    @IBAction func refresh(_ sender: Any) {

        
        if googleMapsAPI.userLatitude == nil && googleMapsAPI.userLongitude == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
        }

        checkForLocation()
        
        storesTable.reloadData()
        
        print("Store list after refresh \(storesList)")
    }
    
    // Checks user location and then gets the store data
    func checkForLocation() {
        if googleMapsAPI.userLatitude != nil && googleMapsAPI.userLongitude != nil {
            getStoreData()
        } else {
            showAlert(title: "Error", message: "Could not get user location: Please enable location services")
        }
    }
}
