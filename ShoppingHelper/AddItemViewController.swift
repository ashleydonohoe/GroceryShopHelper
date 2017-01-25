//
//  AddItemViewController.swift
//  ShoppingHelper
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

        // Do any additional setup after loading the view.
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
        
        addImage.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveItem(_ sender: Any) {
       save()
        dismiss(animated: true, completion: nil)
    }
    
    func save() {
        if let itemName = itemName.text, let itemCategory = itemCategory.titleForSegment(at: itemCategory.selectedSegmentIndex), let itemQuantity = Int(itemQuantity.text!), let itemPrice = itemPrice.text {
            let newItem = GroceryItem(context: context)
            newItem.category = itemCategory
            newItem.name = itemName
            let convertedPrice = (itemPrice as NSString).doubleValue
            newItem.price = convertedPrice
            newItem.quantity = Int32(itemQuantity)
            newItem.favorite = false
            newItem.image = nil
            newItem.completed = false
            
            if let itemImage = itemImagePreview.image {
                newItem.image = itemImage
            }
            
            appDelegate.saveContext()
        } else {
          let alertController = UIAlertController(title: "Cannot Save Item", message: "Name, Category, Quantity, and Price Required", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
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
                view.frame.origin.y -= getKeyboardHeight(notification)
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
