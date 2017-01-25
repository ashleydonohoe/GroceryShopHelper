//
//  CodeForLater.swift
//  ShoppingHelper
//
//  Created by Gabriele on 1/11/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import Foundation
import UIKit

extension AddItemViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    func keyboardWillShow(_ notification:Notification) {
        
                if (!itemCategory.isFirstResponder && !UIDeviceOrientationIsPortrait(UIDevice.current.orientation) && !(itemName.isFirstResponder && !UIDeviceOrientationIsPortrait(UIDevice.current.orientation)))
                    {
                      view.frame.origin.y -= getKeyboardHeight(notification)
                }
        
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    func keyboardWillHide(_ notification:Notification) {
        //        if (!itemCategory.isFirstResponder && !UIDeviceOrientationIsPortrait(UIDevice.current.orientation) && !(itemName.isFirstResponder && !UIDeviceOrientationIsPortrait(UIDevice.current.orientation)))
        //        {
        //            view.frame.origin.y = 0
        //        }
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}
