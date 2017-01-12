//
//  ItemModel.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import Foundation
import UIKit

// Just a test struct for adding an item temporarily
struct Item {
    var name: String
    var category: String
    var quantity:Int
    var price: Double
    var image:UIImage? //Later on, image will be optional when user adds items
    var favorite:Bool = false
}
