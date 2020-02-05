//
//  AddToSettingsViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreData

protocol addBudgetViewControllerDelegate: AnyObject {
    func budgetHasBeenUpdated()
}

class AddBudgetViewController: UIViewController {
    
    weak var delegate: addBudgetViewControllerDelegate?
    
    @IBOutlet weak var budgetSlider: UISlider!
    @IBOutlet weak var budgetValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO:
        // Set slider value to budget value if it exists.
    }
    
    @IBAction func sliderChanged(_ sender: UISlider){
        let sliderValue = Double(sender.value)
        print(sliderValue)
        let roundedValue = round(sliderValue * 1.00) * 1000
        budgetValueLabel.text = currencyFormatter.string(from: NSNumber(value: roundedValue))

    }
    
    @IBAction func saveTapped(_ sender: Any) {
        saveBudgetToUserDefaults()
        
        delegate?.budgetHasBeenUpdated()
        self.navigationController?.popViewController(animated: true)
    }
    
    func roundedSliderValue() -> Double {
        let sliderValue = Double(budgetSlider.value * 1.00)
        let roundedValue = round(sliderValue) * 1000
        print(roundedValue)
        
        return roundedValue

    }
    
    func saveBudgetToUserDefaults() {
        UserDefaults.standard.setValue(roundedSliderValue(), forKey: "budgetTotal")
    }

}

extension Double {
     static let twoFractionDigits: NumberFormatter = {
         let formatter = NumberFormatter()
         formatter.numberStyle = .decimal
         return formatter
     }()
     var formatted: String {
         return Double.twoFractionDigits.string(for: self) ?? ""
     }
 }
