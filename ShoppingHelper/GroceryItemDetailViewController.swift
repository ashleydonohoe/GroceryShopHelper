//
//  GroceryItemDetailViewController.swift
//  ShoppingHelper
//
//  Created by Gabriele on 1/14/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class GroceryItemDetailViewController: UIViewController {
    
    var item:Item?
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = item {
            itemNameLabel.text = item.name
            itemCategoryLabel.text = "Category: " + item.category
            if let image = item.image {
                itemImage.image = image
            }
            quantityLabel.text = String(item.quantity)
            priceLabel.text = "$" + String(item.price)
            if item.favorite {
                favoriteLabel.text = "Yes"
            } else {
                favoriteLabel.text = "No"
            }
        }
    }
}
