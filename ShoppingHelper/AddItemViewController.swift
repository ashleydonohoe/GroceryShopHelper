//
//  AddItemViewController.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemCategory: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    @IBOutlet weak var itemPrice: UITextField!
    @IBOutlet weak var itemImagePreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemName.delegate = self
        itemCategory.delegate = self
        itemQuantity.delegate = self
        itemPrice.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            itemImagePreview.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveItem(_ sender: Any) {
       save()
    }
    
    func save() {
        if let itemName = itemName.text, let itemCategory = itemCategory.text, let itemQuantity = Int(itemQuantity.text!), let itemPrice = Double(itemPrice.text!), let itemImage = itemImagePreview.image {
            
            let newItem = Item(name: itemName, category: itemCategory, quantity: itemQuantity, price: itemPrice, image: itemImage, favorite: false)
            print(newItem)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
