//
//  HoneymoonCellDetailViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import MapKit

class HoneymoonCellDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    
    var activity: Activity?
    
    let sections: [String] = ["Activities", "Wishlist"]
    //This is wrong I'm sure
    let s1Data: [Activity] = []
    let s2Data: [Wishlist] = [] as? [String]
    
    var sectionData: [Int: [String]] = [:]
    
    @IBOutlet weak var hCDVMapView: MKMapView!
    
    @IBOutlet weak var hCDVTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sectionData = [0 : s1Data, 2 : s2Data]
    }
    

    
    @IBAction func addActivityButtonPressed(_ sender: UIButton) {
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (sectionData[section]?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let activityCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as? ActivityCustomTableViewCell else { return UITableViewCell() }
        
        guard let wishlistCell = tableView.dequeueReusableCell(withIdentifier: "WishlistCell", for: indexPath) as? WishlistCustomTableViewCell else { return UITableViewCell() }
        
        // not sure if this is the right thing to check if
        if sectionData == [0 : s1Data] {
            return activityCell
            
        } else {
            return wishlistCell
        }
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let row = indexPath.row
//
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddActivityMapSegue" {
            guard let detailVC = segue.destination as? AddActivityMapViewController,
                
                let indexPath = hCDVTableView.indexPathForSelectedRow else { return }
            //adjust to activity
//            detailVC.book = bookFor(indexPath: indexPath)
//            detailVC.bookController = bookController
        } else if segue.identifier == "ActivityDetailViewSegue" {
            guard let addVC = segue.destination as? ActivityDetailViewController.h else { return }
            // adjust to activity
//            addVC.bookController = bookController
        }
    }
    

}
