//
//  AddWishlistVC.swift
//  TheHoneymoonPlanner
//
//  Created by Brandi Bailey on 2/7/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreData

class AddWishlistVC: UIViewController {

    
    @IBOutlet weak var wishlistNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - FetchedResultsController
       
       lazy var wishlistFetchedResultsController: NSFetchedResultsController<Wishlist> = {
           let fetchRequest: NSFetchRequest<Wishlist> = Wishlist.fetchRequest()
           
           let descriptor = NSSortDescriptor(keyPath: \Wishlist.item, ascending: true)
           fetchRequest.sortDescriptors = [descriptor]
           
           let moc = CoreDataStack.shared.mainContext
           let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                     managedObjectContext: moc,
                                                                     sectionNameKeyPath: "item",
                                                                     cacheName: nil)
           
           fetchedResultsController.delegate = self
           
           do {
               try fetchedResultsController.performFetch()
           } catch {
               print("error performing initial fetch for frc: \(error)")
           }
           
           return fetchedResultsController
           
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.wishlistNameTextField.delegate = self
    }
    
        // MARK: - IBActions
    
    @IBAction func doneTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - Extensions

extension AddWishlistVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wishlistFetchedResultsController.sections?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wishlistFetchedResultsController.sections?[section].numberOfObjects ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wishlistCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let wishlist = wishlistFetchedResultsController.object(at: indexPath)
        
        wishlistCell.textLabel?.text = wishlist.item
        return wishlistCell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let item = wishlistFetchedResultsController.object(at: indexPath)
            WishlistController.shared.delete(item)
        }
    }
    
}

extension AddWishlistVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let str = textField.text,
            !str.isEmpty else { return false }
        
        WishlistController.shared.create(with: str)
        
        wishlistNameTextField.text = ""
        wishlistNameTextField.resignFirstResponder()
        
        return true
    }
}

extension AddWishlistVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet([sectionIndex])
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default:
            print(#line, #file, "unexpected NSFetchedResultsChangeType: \(type)")
        }
    }
    
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            fatalError()
        }
    }
}

