//
//  GroceryItemDetailViewController.swift
//  ShoppingHelper
//
//  Created by Gabriele on 1/14/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit
import CoreData

class GroceryItemDetailViewController: UIViewController {
    
    var item:GroceryItem?
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Loads info for selected item from tableview
        loadGroceryItemDetails()

    }
    
    // Allows user to update favorite status by tapping the star
    @IBAction func changeFavorite(_ sender: Any) {
        let currentItem = item!
        let currentStatus = item!.favorite
        currentItem.favorite = !currentStatus
        
        // Updates star icon based on favorite
        if item!.favorite {
            favoriteButton.setImage(UIImage(named: "starfilled"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "starnofill"), for: .normal)
        }
        
        print("After: \(item)")
        appDelegate.saveContext()
    }
    
    func loadGroceryItemDetails() {
        if let item = item {
            print("Before: \(item)")
            itemNameLabel.text = item.name
            itemCategoryLabel.text = "Category: " + item.category!
            if let image = item.image {
                itemImage.image = image as? UIImage ?? nil
            }
            quantityLabel.text = String(item.quantity)
            priceLabel.text = "$" + String(item.price)
            if item.favorite {
                favoriteButton.setImage(UIImage(named: "starfilled"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "starnofill"), for: .normal)
            }
            
        }
        

    }
}
