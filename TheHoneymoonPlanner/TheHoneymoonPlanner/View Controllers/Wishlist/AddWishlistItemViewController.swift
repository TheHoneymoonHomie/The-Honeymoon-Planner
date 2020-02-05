//
//  AddWishlistItemViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Brandi Bailey on 2/3/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreData

class AddWishlistItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    
    @IBOutlet weak var wishlistNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.wishlistNameTextField.delegate = self
        
        fetchWishlistItems()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)

        let wishlist = wishlists[indexPath.row]
        cell.textLabel?.text = wishlist.item

               return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let wishlist = wishlists[indexPath.row]
            CoreDataStack.context.delete(wishlist)
            
            CoreDataStack.saveContext()
            fetchWishlistItems()
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func addWishlistItem() {

        let wishlist = Wishlist(context: CoreDataStack.context)
        wishlist.item = wishlistNameTextField.text
        
        CoreDataStack.saveContext()
        fetchWishlistItems()
    }
    
    func fetchWishlistItems() {
        
        let fetchRequest: NSFetchRequest<Wishlist> = Wishlist.fetchRequest()
        do {
            wishlists = try CoreDataStack.context.fetch(fetchRequest)
            tableView.reloadData()
            print(wishlists)
            print(wishlists.count)
        } catch {
            print(error)
        }
    }
    
}

extension AddWishlistItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        addWishlistItem()
        wishlistNameTextField.text = ""
        wishlistNameTextField.resignFirstResponder()
        return true
    }
}
