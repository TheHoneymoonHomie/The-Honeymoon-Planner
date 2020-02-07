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

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBudgetVC = AddBudgetViewController()
        addBudgetVC.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        fetchWishlistItems()
        
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        fetchWishlistItems()
        updateViews()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistItemCell", for: indexPath)

        let wishlist = wishlists[indexPath.row]
        cell.textLabel?.text = wishlist.item

               return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let wishlist = wishlists[indexPath.row]
//            CoreDataStack.context.delete(wishlist)
//
//            CoreDataStack.saveContext()
//            fetchWishlistItems()
        }
    }
    
//    func fetchWishlistItems() {
//
//        let fetchRequest: NSFetchRequest<Wishlist> = Wishlist.fetchRequest()
//        do {
////            wishlists = try CoreDataStack.context.fetch(fetchRequest)
//            tableView.reloadData()
//            print(wishlists)
//            print(wishlists.count)
//        } catch {
//            print(error)
//        }
//    }
    
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


