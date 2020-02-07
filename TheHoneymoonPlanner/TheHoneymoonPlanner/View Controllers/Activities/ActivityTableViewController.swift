////
////  ActivityTableViewController.swift
////  TheHoneymoonPlanner
////
////  Created by Brandi Bailey on 2/6/20.
////  Copyright © 2020 Jonalynn Masters. All rights reserved.
////
//
//import UIKit
//
//class ActivityTableViewController: UITableViewController {
//    
//    lazy var activityFetchedResultsController: NSFetchedResultsController<Activity> = {
//        let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest()
//        
//        let descriptor = NSSortDescriptor(keyPath: \Activity.name, ascending: true)
//        fetchRequest.sortDescriptors = [descriptor]
//        
//        let moc = CoreDataStack.shared.mainContext
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
//                                                                  managedObjectContext: moc,
//                                                                  sectionNameKeyPath: "name",
//                                                                  cacheName: nil)
//        
//        fetchedResultsController.delegate = self
//        fetchRequest.sortDescriptors = [descriptor]
//        
//        fetchedResultsController.delegate = self
//        fetchedResultsController.delegate = self
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            print("error performing initial fetch for frc: \(error)")
//        }
//        return fetchedResultsController
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//        
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
//    
//    // MARK: - Table view data source
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return fetchedResultsController.sections.count
//        
//        
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        return sections[section]
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchedResultsController.sections
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let activityCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as? ActivityCustomTableViewCell else { return UITableViewCell() }
//        
//        guard let wishlistCell = tableView.dequeueReusableCell(withIdentifier: "WishlistItemCell", for: indexPath) as? WishlistCustomTableViewCell else { return UITableViewCell() }
//        
//        // TODO: This should fill the sections with the array of stuff
//        if indexPath.section == 0 {
//            if activities.count == 0 {
//                return UITableViewCell()
//            } else {
//                //            let anActivity = activities[indexPath.row]
//                //            activityCustomCell.activityNameLable.text = anActivity.name
//                return activityCell }
//        } else {
//            let wishlist = wishlists[indexPath.row]
//            
//            wishlistCustomCell.wishlistItemLabel?.text = wishlist.item
//            return wishlistCell
//        }
//    }
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//    
//}
//
//extension HoneymoonCellDetailViewController: NSFetchedResultsControllerDelegate {
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//    
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
//                    didChange sectionInfo: NSFetchedResultsSectionInfo,
//                    atSectionIndex sectionIndex: Int,
//                    for type: NSFetchedResultsChangeType) {
//        let indexSet = IndexSet([sectionIndex])
//        switch type {
//        case .insert:
//            tableView.insertSections(indexSet, with: .fade)
//        case .delete:
//            tableView.deleteSections(indexSet, with: .fade)
//        default:
//            print(#line, #file, "unexpected NSFetchedResultsChangeType: \(type)")
//        }
//    }
//    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
//                    didChange anObject: Any,
//                    at indexPath: IndexPath?,
//                    for type: NSFetchedResultsChangeType,
//                    newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            guard let newIndexPath = newIndexPath else { return }
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        case .move:
//            guard let indexPath = indexPath,
//                let newIndexPath = newIndexPath else { return }
//            tableView.moveRow(at: indexPath, to: newIndexPath)
//        case .update:
//            guard let indexPath = indexPath else { return }
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        case .delete:
//            guard let indexPath = indexPath else { return }
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        @unknown default:
//            print(#line, #file, "unknown NSFetchedResultsChangeType: \(type)")
//        }
//    }
//}
