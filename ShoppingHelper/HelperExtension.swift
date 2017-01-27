//
//  HelperExtension.swift
//  Grocery Shop Helper
//
//  Created by Gabriele on 1/27/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Helper method for showing alert messages
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

}
