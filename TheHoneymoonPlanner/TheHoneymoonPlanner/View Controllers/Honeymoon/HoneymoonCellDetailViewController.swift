//
//  HoneymoonCellDetailViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

enum headerType: String {
    case ac = "Activities"
    case wl = "Wishlist"
}

import UIKit
import MapKit
import CoreData

class HoneymoonCellDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    var activty: Activity?
    var activities: [Activity] = []
    
    let sections: [String] = ["Activities", "Wishlist"]
    //This is wrong I'm sure
    let s1Data: [Activity] = []
    let s2Data: [Wishlist] = []

    var sectionData: [Int: [Any]] = [:]
    
    @IBOutlet weak var hCDVMapView: MKMapView!
    
    @IBOutlet weak var hCDVTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hCDVTableView.reloadData()
        hCDVTableView.delegate = self
        hCDVTableView.dataSource = self
        fetchActivities()
        fetchWishlistItems()
        //sectionData = [0 : s1Data, 2 : s2Data]
    }
    
    @IBAction func addActivityButtonPressed(_ sender: UIButton) {
        
    }
    
    func fetchActivities() {
        let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest()
        do {
            activities = try CoreDataStack.context.fetch(fetchRequest)
            hCDVTableView.reloadData()
            print(activities)
            print(activities.count)
        } catch {
            print(error)
        }
    }
    
    func fetchWishlistItems() {
        
        let fetchRequest: NSFetchRequest<Wishlist> = Wishlist.fetchRequest()
        do {
            wishlists = try CoreDataStack.context.fetch(fetchRequest)
            hCDVTableView.reloadData()
            print(wishlists)
            print(wishlists.count)
        } catch {
            print(error)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
        

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return sections[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sections.contains("Activities") {
            activities.count

        } else {
            wishlists.count
        }
        
        return sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let activityCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as? ActivityCustomTableViewCell else { return UITableViewCell() }

        guard let wishlistCell = tableView.dequeueReusableCell(withIdentifier: "WishlistItemCell", for: indexPath) as? WishlistCustomTableViewCell else { return UITableViewCell() }

        // not sure if this is the right thing to check if
        //if sectionData == [0 : s1Data]
        //if sectionData.capacity == 0
        
//        switch sections.contains(headerType) {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
        
        if indexPath.section == 0 {
            return activityCell
        } else {
            return wishlistCell
        }
       
        
//        if sections.contains("Activities") {
//            return activityCell
//
//        } else {
//            return UITableViewCell() }
//
//        if sections.contains("Wishlist") {
//            let wishlist = wishlists[indexPath.row]
//            wishlistCell.textLabel?.text = wishlist.item
//            return wishlistCell
//        } else {
//            return UITableViewCell()
//        }

    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "AddActivityMapSegue" {
                guard let detailVC = segue.destination as? AddActivityMapViewController,
                    
                    let indexPath = hCDVTableView.indexPathForSelectedRow else { return }
                //adjust to activity
                detailVC.activty = activty
                detailVC.activities = activities
                detailVC.wishlist = wishlist
                detailVC.wishlists = wishlists
                

            } else if segue.identifier == "ActivityDetailViewSegue" {
                //guard let addVC = segue.destination as? ActivityDetailViewController.h else { return }
                // adjust to activity
    //            addVC.bookController = bookController
            }
        }

}
