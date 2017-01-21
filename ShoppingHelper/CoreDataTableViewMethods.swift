//
//  CoreDataTableViewMethods.swift
//  ShoppingHelper
//
//  Created by Ashley Donohoe on 1/20/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit
import CoreData

extension GroceryListViewController {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        groceryItemTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        groceryItemTable.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case .insert:
            if let indexPath = newIndexPath {
                groceryItemTable.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                groceryItemTable.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = groceryItemTable.cellForRow(at: indexPath)
                // TODO: update cell data
            }
            break
        case .move:
            if let indexPath = indexPath {
                groceryItemTable.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let indexPath = newIndexPath {
                groceryItemTable.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }


}
