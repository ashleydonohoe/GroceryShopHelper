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

        // Do any additional setup after loading the view.
        print(item)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
