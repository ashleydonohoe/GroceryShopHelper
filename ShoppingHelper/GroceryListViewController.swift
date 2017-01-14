//
//  GroceryListViewController.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sampleItems: [Item] = [Item(name: "Bacon", category: "Meat", quantity: 2, price: 3.99, image: nil, favorite: false), Item(name: "Cereal", category: "Grains", quantity: 1, price: 3.89, image: nil, favorite: true) ]
    
    @IBOutlet weak var groceryItemTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(GroceryListViewController.addItem))
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 231, green: 76, blue: 60, alpha: 1)
        //UIColor(red: 231, green: 76, blue: 60, alpha: 1)
        
    }
    
    func addItem() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddItemViewController") as! AddItemViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    // TODO: Later update to account for categories
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // TODO: Make custom cell to show item name, price, quantity, and image
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "ItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as UITableViewCell
        cell.textLabel?.text = self.sampleItems[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sampleItems.count
    }
}
