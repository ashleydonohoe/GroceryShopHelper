//
//  GroceryListViewController.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit
import CoreData

class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
//    var sampleItems: [Item] = [Item(name: "Bacon", category: "Meat", quantity: 2, price: 3.99, image: UIImage(named: "bacon.jpg")!, favorite: false), Item(name: "Cereal", category: "Grains", quantity: 1, price: 3.89, image: nil, favorite: true) ]
    
    @IBOutlet weak var sortControl: UISegmentedControl!
    @IBOutlet weak var groceryItemTable: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController<GroceryItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(GroceryListViewController.addItem))
        
//        addTestItem()
        fetchGroceryListData()
        
    }
    
    func addItem() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddItemViewController") as! AddItemViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    // TODO: Later update to account for categories
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        return 0
    }
    
    // TODO: Make custom cell to show item name and price
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "ItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)! as! ItemCell
        let groceryItem = fetchedResultsController.object(at: indexPath)
        // Show title and image based on status
        cell.itemNameLabel.text = groceryItem.name
        
        if groceryItem.completed {
            cell.itemStatus.image = UIImage(named: "completed")
        } else {
            cell.itemStatus.image = UIImage(named: "notcompleted")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GroceryItemDetailViewController") as! GroceryItemDetailViewController
//        controller.item = sampleItems[(indexPath as NSIndexPath).row] as Item
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func fetchGroceryListData() {
        let fetchRequest: NSFetchRequest<GroceryItem> = GroceryItem.fetchRequest()
        let showAllItems = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [showAllItems]
        
        if sortControl.selectedSegmentIndex == 1 {
            fetchRequest.predicate = NSPredicate(format: "favorite == %@", true as CVarArg)
        }
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do {
            try self.fetchedResultsController.performFetch()
            groceryItemTable.reloadData()
        } catch {
            print(error)
            let alertController = UIAlertController(title: "Error", message: "Could not fetch data", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func addTestItem() {
        let groceryItem = GroceryItem(context: context)
        groceryItem.name = "Bacon"
        groceryItem.price = 3.99
        groceryItem.quantity = 3
        groceryItem.favorite = true
        groceryItem.image = UIImage(named: "bacon.jpg")
        groceryItem.category = "Dairy"
        groceryItem.completed = false
        
        appDelegate.saveContext()
        
    }
}
