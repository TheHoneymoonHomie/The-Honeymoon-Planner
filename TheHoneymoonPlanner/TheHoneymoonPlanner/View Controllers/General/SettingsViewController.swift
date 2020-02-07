//
//  SettingsViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//
//WishlistItemCell

import UIKit
import CoreData

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
}()

class SettingsViewController: UIViewController {
    
    var budgetHasBeenSet: Bool = false {
        didSet {
            updateViews()
            budgetHasBeenSet = false
        }
    }
    
    @IBOutlet weak var budgetEditButton: UIButton!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    @IBOutlet weak var addWishlistItemButton: UIButton!
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
        
        let addBudgetVC = AddBudgetViewController()
        addBudgetVC.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    func updateViews() {
        let budgetValue = UserDefaults.standard.double(forKey: "budgetTotal")
        budgetAmountLabel.text = budgetValue > 0.0 ? currencyFormatter.string(from: NSNumber(value: budgetValue)) : "$0.00"
    }
    


     // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "AddToSettingsSegue" {
            guard let addBudgetVC = segue.destination as? AddBudgetViewController else { return }
            addBudgetVC.delegate = self
        }
    }
}

extension SettingsViewController: addBudgetViewControllerDelegate {
    func budgetHasBeenUpdated() {
        budgetHasBeenSet = true
        
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wishlistFetchedResultsController.sections?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wishlistFetchedResultsController.sections?[section].numberOfObjects ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wishlistCell = tableView.dequeueReusableCell(withIdentifier: "WishlistItemCell", for: indexPath)
        
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

extension SettingsViewController: NSFetchedResultsControllerDelegate {
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


