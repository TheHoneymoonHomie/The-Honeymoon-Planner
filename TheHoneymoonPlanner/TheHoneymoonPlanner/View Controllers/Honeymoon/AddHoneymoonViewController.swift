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

class AddHoneymoonViewController: UIViewController {
    
    var vacationLocation: CLLocation?


    @IBOutlet weak var honeymoonNameTextField: UITextField!
    @IBOutlet weak var selectLocationButton: UIButton!
    @IBOutlet weak var startTextField: UITextField!
    
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}