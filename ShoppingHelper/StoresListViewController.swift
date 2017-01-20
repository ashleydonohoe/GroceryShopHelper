//
//  StoresListViewController.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class StoresListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var storesTable: UITableView!
    let googleMapsAPI = GooglePlacesAPIClient.sharedInstance()
    var storesList = [Store]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getStoreData()
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
        
    }
    
    func getStoreData() {
        activity.isHidden = false
        activity.startAnimating()
        
        googleMapsAPI.getListOfStores { (success) in
            if success {
                self.storesList = self.googleMapsAPI.stores
                
                performUIUpdatesOnMain {
                    self.storesTable.reloadData()
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: "Could not download store locations", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        performUIUpdatesOnMain {
            self.activity.isHidden = true
            self.activity.stopAnimating()
        }

    }
    
    @IBAction func refresh(_ sender: Any) {
        getStoreData()
    }
}
