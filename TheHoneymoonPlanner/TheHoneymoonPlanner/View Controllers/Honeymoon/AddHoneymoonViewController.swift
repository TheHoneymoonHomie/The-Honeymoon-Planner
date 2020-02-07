//
//  AddHoneymoonViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Brandi Bailey on 2/2/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class AddHoneymoonViewController: UIViewController  {
    
    let vacationController = VacationController()
    
    // MARK: - FRC for Wishlist Items
    
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
    
    // MARK: Properties
    var startDatePicker: UIDatePicker?
    var endDatePicker: UIDatePicker?
    var vacationLocation: CLLocation?
    
    var vacationLocationTitle: String?
    //    var wishlist: Wishlist?
    //    var wishlists: [Wishlist] = []
    
    // MARK: Outlets
    
    @IBOutlet weak var honeymoonNameTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var vacationLocationLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vacationLocationLabel.text = vacationLocationTitle
        print("VactaionLocationTitle from AddHonemoonVC: \(vacationLocationTitle)")
        print(vacationLocation)
    }
    
    func loadDatePicker() {
        startDatePicker = UIDatePicker()
        endDatePicker = UIDatePicker()
        startDatePicker?.datePickerMode = .dateAndTime
        endDatePicker?.datePickerMode = .dateAndTime
        
        startDatePicker?.addTarget(self, action: #selector(AddHoneymoonViewController.startDateChanged(datePicker:)), for: .valueChanged)
        endDatePicker?.addTarget(self, action: #selector(AddHoneymoonViewController.endDateChanged(datePicker:)), for: .valueChanged)
        
        let startTapGesture = UITapGestureRecognizer(target: self, action: #selector(AddHoneymoonViewController.startViewTapped(gestureRecognizer:)))
        
        let endTapGesture = UITapGestureRecognizer(target: self, action: #selector(AddHoneymoonViewController.endViewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(startTapGesture)
        startTextField.inputView = startDatePicker
        
        view.addGestureRecognizer(endTapGesture)
        endTextField.inputView = endDatePicker
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: Any) {
    }

    
    @IBAction func saveTapped(_ sender: Any) {
        
        print("Save tapped")
        saveVacationToCoreData()
        print(vacationController.loadVacationFromPersistentStore().count)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    func saveVacationToCoreData() {
        
        let imageURL = { () -> URL in
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime]
            
            let name = formatter.string(from: Date())
            let fileURL = documentsDirectory.appendingPathComponent(name).appendingPathExtension("jpg")
            
            return fileURL
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        guard let vacationLocation = self.vacationLocation else { return }
        
        let latitude = Double(vacationLocation.coordinate.latitude)
        let longitude = Double(vacationLocation.coordinate.longitude)
        
        let locationName = vacationLocationTitle
        
        let honeymooonName = honeymoonNameTextField?.text
        
        let vacationWishlistItems: [Wishlist] = []
        let vacationActivities: [Activity] = []
        
        let vacationStartDate = startDatePicker?.date
        let vacationEndDate = endDatePicker?.date
        
        vacationController.createVacation(with: 0.00, date_start: vacationStartDate, date_end: vacationEndDate, imageURL: imageURL(), latitude: latitude, longitude: longitude, location: locationName, title: honeymooonName ?? "", wishlist: vacationWishlistItems, activities: vacationActivities, context: .context)
        
        vacationController.saveToPersistentStore()

    }
    
    // MARK: - ObjC Funcs
    
    @objc func startViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func startDateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        startTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func endViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func endDateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        endTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    // MARK: Tableview Data Sources
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Wishlist Items"
    }
    
}

// MARK: - Extensions

extension AddHoneymoonViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension AddHoneymoonViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        honeymoonNameTextField.resignFirstResponder()
        
        return true
    }
}

extension AddHoneymoonViewController: NSFetchedResultsControllerDelegate {
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
