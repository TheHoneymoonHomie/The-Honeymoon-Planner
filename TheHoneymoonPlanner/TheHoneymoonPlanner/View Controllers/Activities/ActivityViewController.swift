//
//  ActivityViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

//#import ActivityDetailViewController.h

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var activityPriceTextField: UITextField!
    @IBOutlet weak var activityDescriptionTextView: UITextView!
    
    @IBOutlet weak var startTextField: UITextField!
    
    @IBOutlet weak var endTextField: UITextField!
    
    var wishlist: Wishlist?
    var wishlists: [Wishlist] = []
    var activity: Activity?
    var activities: [Activity] = []
    
    var activityName = ""
    var activityPrice = ""
    var activityDescription = ""
    var activityStart = ""
    var activityEnd = ""
    
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    var activityLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        startDatePicker = UIDatePicker()
            endDatePicker = UIDatePicker()
            startDatePicker?.datePickerMode = .dateAndTime
            endDatePicker?.datePickerMode = .dateAndTime
            
            startDatePicker?.addTarget(self, action: #selector(ActivityViewController.startDateChanged(datePicker:)), for: .valueChanged)
             endDatePicker?.addTarget(self, action: #selector(ActivityViewController.endDateChanged(datePicker:)), for: .valueChanged)
            
            let startTapGesture = UITapGestureRecognizer(target: self, action: #selector(ActivityViewController.startViewTapped(gestureRecognizer:)))
            
            let endTapGesture = UITapGestureRecognizer(target: self, action: #selector(ActivityViewController.endViewTapped(gestureRecognizer:)))
            
            view.addGestureRecognizer(startTapGesture)
            startTextField.inputView = startDatePicker
            
            view.addGestureRecognizer(endTapGesture)
            endTextField.inputView = endDatePicker
        }
/*
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
*/
    func saveActivityToCoreData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
//        guard let startTextField.text = dateFormatter.string(from: startDatePicker.date) else { return dateFormatter.}
//        endTextField.text = dateFormatter.string(from: endDatePicker?.date)
        
        guard let activityLocation = self.activityLocation else { return }
        
        let latitude = Double(activityLocation.coordinate.latitude)
        let longitude = Double(activityLocation.coordinate.longitude)
        
        activity?.act_cost = activityPriceTextField.text as? Double ?? 0.00
        activity?.act_date_end = nil
        activity?.act_date_start = nil
        activity?.act_latitude = latitude
        activity?.act_longitude = longitude
        activity?.name = activityNameTextField.text
        //ativity.vacation = ?
        CoreDataStack.saveContext()
        
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
        // Do any additional setup after loading the view.
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        self.activityName = activityNameTextField.text ?? ""
        self.activityPrice = activityPriceTextField.text ?? ""
        self.activityDescription = activityDescriptionTextView.text ?? ""
        self.activityStart = startTextField.text ?? ""
        self.activityEnd = endTextField.text ?? ""
        saveActivityToCoreData()
        
        performSegue(withIdentifier: "SaveActivityAndShowDetailsSegue", sender: self)
    }
    

    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    var vc = segue.destination as! ActivityDetailViewController
    //}
    

}
