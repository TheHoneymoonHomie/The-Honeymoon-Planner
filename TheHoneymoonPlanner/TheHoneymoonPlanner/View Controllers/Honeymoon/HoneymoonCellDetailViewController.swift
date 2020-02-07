//
//  HoneymoonCellDetailViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class HoneymoonCellDetailViewController: UIViewController {
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    var activty: Activity?
    var activities: [Activity] = []
    
    var wishlistCustomCell = WishlistCustomTableViewCell()
    var activityCustomCell = ActivityCustomTableViewCell()
    
    let sections: [String] = ["Activities", "Wishlist"]
    //This is wrong I'm sure
    let s1Data: [Activity] = []
    let s2Data: [Wishlist] = []
    
    var sectionData: [Int: [Any]] = [:]
    
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
    
    
    @IBOutlet weak var hCDVTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableView.reloadData()
        //        tableView.delegate = self
        //        tableView.dataSource = self
        //
        //sectionData = [0 : s1Data, 2 : s2Data]
        print(wishlistFetchedResultsController.fetchedObjects?.count ?? 0)
    }
    
    @IBAction func addActivityButtonPressed(_ sender: UIButton) {
        
    }
    
    func fetchActivities() {
        let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest()
        do {
            let moc = CoreDataStack.shared.mainContext
            activities = try moc.fetch(fetchRequest)
            hCDVTableView.reloadData()
            print(activities)
            print(activities.count)
        } catch {
            print(error)
        }
    }
    
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return wishlistFetchedResultsController.sections?.count ?? 1
    //    }
    //
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //        return sections[section]
    //    }
    //
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //
    //        switch (section) {
    //        case 0:
    //            return activities.count
    //        case 1:
    //            return wishlists.count
    //        default:
    //            return 1
    //        }
    //
    //    }
    //
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddActivityMapSegue" {
            guard let detailVC = segue.destination as? AddActivityMapViewController,
                let indexPath = hCDVTableView.indexPathForSelectedRow else { return }
            
            //            let activity = activityFetchedResultsController.object(at: indexPath)
            let wishlist = wishlistFetchedResultsController.object(at: indexPath)
            
            //adjust to activity
            //            detailVC.activity = activity
            //            detailVC.activities = activities
            detailVC.wishlist = wishlist
            //            detailVC.wishlists = wishlists
            
            
        } else if segue.identifier == "ActivityDetailViewSegue" {
            //guard let addVC = segue.destination as? ActivityDetailViewController.h else { return }
            // adjust to activity
            //            addVC.bookController = bookController
        }
    }
    
}

extension HoneymoonCellDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
}

extension HoneymoonCellDetailViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        hCDVTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        hCDVTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet([sectionIndex])
        switch type {
        case .insert:
            hCDVTableView.insertSections(indexSet, with: .fade)
        case .delete:
            hCDVTableView.deleteSections(indexSet, with: .fade)
        default:
            print(#line, #file, "unexpected NSFetchedResultsChangeType: \(type)")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            hCDVTableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            hCDVTableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            hCDVTableView.reloadRows(at: [indexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            hCDVTableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            print(#line, #file, "unknown NSFetchedResultsChangeType: \(type)")
        }
    }
    
}
