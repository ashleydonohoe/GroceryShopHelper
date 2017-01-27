//
//  AddItemViewController.swift
//  GroceryShopHelper
//
//  Created by Ashley Donohoe on 1/10/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemCategory: UISegmentedControl!
    @IBOutlet weak var itemQuantity: UITextField!
    @IBOutlet weak var itemPrice: UITextField!
    @IBOutlet weak var itemImagePreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemName.delegate = self
        itemQuantity.delegate = self
        itemPrice.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func cancelItem(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    // Allows user to select image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            itemImagePreview.image = image
        }
        
        // Hides the select image button after choosing to prevent errors
        addImage.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    // Calls save method that does some error checking and then dismisses add item view
    @IBAction func saveItem(_ sender: Any) {
        save()
        dismiss(animated: true, completion: nil)
    }
    
    func save() {
        // Checks if the required fields, itemName and itemQuantity, are filled
        if (itemName.text?.isEmpty)! || (itemQuantity.text?.isEmpty)! || (itemPrice.text?.isEmpty)! {
            showAlert(title: "Incomplete Data", message: "Item name, category, price and quantity are both required fields")
        }
        
        
        if let itemName = itemName.text, let itemCategory = itemCategory.titleForSegment(at: itemCategory.selectedSegmentIndex), let itemQuantity = Int(itemQuantity.text!), let itemPrice = itemPrice.text {
            let newItem = GroceryItem(context: context)
            newItem.category = itemCategory
            newItem.name = itemName
            
            // For numerical values, currently the app is set to only show number/decimal keyboards
            newItem.price = Double(itemPrice)!
            newItem.quantity = Int32(itemQuantity)
            
            newItem.favorite = false
            
            // Since images are optional, checks if one was set
            if let itemImage = itemImagePreview.image {
                newItem.image = itemImage
            } else {
                newItem.image = nil
            }
            
            appDelegate.saveContext()
        }
    }
}

extension AddItemViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Keyboard hiding/showing methods taken from UIKit Fundamentals course with some adaptations to account for my form
    func keyboardWillShow(_ notification:Notification) {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            if itemQuantity.isFirstResponder || itemPrice.isFirstResponder {
                view.frame.origin.y = -getKeyboardHeight(notification)
            }
        }
    }
    
    // Hiding keyboard
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

}
