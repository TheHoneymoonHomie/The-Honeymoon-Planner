//
//  HoneymoonCollectionViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreData

class HoneymoonCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    var vacationController = VacationController()
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    var activty: Activity?
    var activities: [Activity] = []
    var vacations: [Vacation] = []
    
    // MARK: - FRC
    
    lazy var vacationFetchedResultsController: NSFetchedResultsController<Vacation> = {
        let fetchRequest: NSFetchRequest<Vacation> = Vacation.fetchRequest()
        
        let descriptor = NSSortDescriptor(keyPath: \Vacation.title, ascending: true)
        fetchRequest.sortDescriptors = [descriptor]
        
        let moc = CoreDataStack.shared.mainContext
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: moc,
                                                                  sectionNameKeyPath: "title",
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
        
        vacationController.loadVacationFromPersistentStore()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vacationController.loadVacationFromPersistentStore()
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return vacationFetchedResultsController.sections?.count ?? 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return vacationFetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityCollectionViewCell", for: indexPath) as? HoneymoonCustomCollectionViewCell else { return UICollectionViewCell() }
        
        let aVacation = vacationFetchedResultsController.object(at: indexPath)
        
        cell.vacationNameLabel.text = aVacation.title
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddHoneymoonFromCollectionVCSegue" {
            let destinationVC = segue.destination as? AddhoneyMoonCellViewController
            
        } else if segue.identifier == "CollectionCellDetailViewSegue" {
            
            let destinationVC = segue.destination as? HoneymoonCellDetailViewController
            
            destinationVC?.activty = activty
            destinationVC?.activities = activities
            destinationVC?.wishlist = wishlist
            destinationVC?.wishlists = wishlists

        }
    }
    
}


