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

class AddHoneymoonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    // MARK: Properties
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    var vacationLocation: CLLocation?
    
    var vacationLocationTitle: String?
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    
    // MARK: Outlets
    @IBOutlet weak var honeymoonNameTextField: UITextField!
    @IBOutlet weak var selectLocationButton: UIButton!
    @IBOutlet weak var startTextField: UITextField!
    
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var vacationLocationLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        fetchWishlistItems()
        
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
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
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
        
        let vacation = Vacation(context: CoreDataStack.context)
        
        guard let vacationLocation = self.vacationLocation else { return }
        
        let latitude = Double(vacationLocation.coordinate.latitude)
        let longitude = Double(vacationLocation.coordinate.longitude)
        
        vacation.cost = costTextField.text as? Double ?? 0.00
        // TODO: FIX THIS
        vacation.date_end = nil
        vacation.date_start = nil
        vacation.imageURL = imageURL()
        vacation.latitude = latitude
       // vacation.location = vacationLocation
        vacation.longitude = longitude
        vacation.title = honeymoonNameTextField.text
        vacation.location = vacationLocationLabel.text
        
        CoreDataStack.saveContext()
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
    
    func fetchVacationLocationTitleAndPressedLocation() {
        
    }
    
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
