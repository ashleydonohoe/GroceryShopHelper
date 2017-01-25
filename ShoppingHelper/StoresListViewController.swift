//
//  StoresListViewController.swift
//  ShoppingHelper
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
        
        // Setting up location manager to get permission
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    func getStoreData() {
        self.refreshButton.isEnabled = false
        activity.isHidden = false
        activity.startAnimating()
        
        googleMapsAPI.getListOfStores { (success) in
            if success {
                self.storesList = self.googleMapsAPI.stores
                
                performUIUpdatesOnMain {
                    self.activity.stopAnimating()
                    self.activity.isHidden = true
                    self.storesTable.reloadData()
                    self.refreshButton.isEnabled = true
                }
            } else {
                performUIUpdatesOnMain {
                    let alertController = UIAlertController(title: "Error", message: "Could not download store locations", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                    
                    self.refreshButton.isEnabled = true
                    self.activity.isHidden = true
                    self.activity.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        checkForLocation()
        storesTable.reloadData()
    }
    
    func checkForLocation() {
        if googleMapsAPI.userLatitude != nil && googleMapsAPI.userLongitude != nil {
            getStoreData()
        } else {
            let alertController = UIAlertController(title: "Error", message: "Could not get user location: Please enable Location Services", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
    }
}
