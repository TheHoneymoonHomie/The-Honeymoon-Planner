//
//  HoneymoonCollectionViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "ActivityCollectionViewCell"

class HoneymoonCollectionViewController: UICollectionViewController {
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    var activty: Activity?
    var activities: [Activity] = []
    var vacations: [Vacation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVacationFromCoreData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    func fetchVacationFromCoreData() {
        let fetchRequest: NSFetchRequest<Vacation> = Vacation.fetchRequest()
               do {
                   vacations = try CoreDataStack.context.fetch(fetchRequest)
                   print(vacations)
               } catch {
                   print(error)
               }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //UPDate this to activityController or whatever
        return activities.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HoneymoonCustomCollectionViewCell else { return UICollectionViewCell() }
        
        cell.activty = activty
        cell.activities = activities
        cell.wishlist = wishlist
        cell.wishlists = wishlists
        
        //loadImage function
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddHoneymoonFromCollectionVCSegue" {
            let destinationVC = segue.destination as? AddhoneyMoonCellViewController
            //destinationVC?.honeymoonController = honeymoonController
//            destinationVC?.postController = postController
            
        } else if segue.identifier == "CollectionCellDetailViewSegue" {
            
            let destinationVC = segue.destination as? HoneymoonCellDetailViewController
            
            destinationVC?.activty = activty
            destinationVC?.activities = activities
            destinationVC?.wishlist = wishlist
            destinationVC?.wishlists = wishlists
            //Example work
//            guard let indexPath = collectionView.indexPathsForSelectedItems?.first,
//                let postID = postController.posts[indexPath.row].id else { return }
//
//            destinationVC?.postController = postController
//            destinationVC?.post = postController.posts[indexPath.row]
//            destinationVC?.imageData = cache.value(for: postID)
//            destinationVC?.cache = cache
        }
    }

}
