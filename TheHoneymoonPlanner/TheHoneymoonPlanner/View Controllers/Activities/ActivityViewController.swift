//
//  ActivityViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var activityPriceTextField: UITextField!
    @IBOutlet weak var activityDescriptionTextView: UITextView!
    
    @IBOutlet weak var startTextField: UITextField!
    
    @IBOutlet weak var endTextField: UITextField!
    
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?

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
        // Do any additional setup after loading the view.
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
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
