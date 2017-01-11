//
//  AddItemViewController.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemCategory: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    @IBOutlet weak var itemPrice: UITextField!
    @IBOutlet weak var itemImagePreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelItem(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    }
    
    @IBAction func saveItem(_ sender: Any) {
        if let itemName = itemName.text, let itemCategory = itemCategory.text, let itemQuantity = Int(itemQuantity.text!), let itemPrice = Double(itemPrice.text!) {
            
            var newItem = Item(name: itemName, category: itemCategory, quantity: itemQuantity, price: itemPrice, image: nil, favorite: false)
            print(newItem)
        }
    }
}
