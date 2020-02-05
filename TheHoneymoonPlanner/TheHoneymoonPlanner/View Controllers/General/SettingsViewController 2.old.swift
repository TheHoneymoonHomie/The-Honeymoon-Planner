//
//  SettingsViewController.swift
//  TheHoneymoonPlanner
//
//  Created by Jonalynn Masters on 1/31/20.
//  Copyright © 2020 Jonalynn Masters. All rights reserved.
//

import UIKit
import CoreData

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
}()

class SettingsViewController: UIViewController {
    
    var budgetHasBeenSet: Bool = false {
        didSet {
            updateViews()
            budgetHasBeenSet = false
        }
    }
    
    
    @IBOutlet weak var budgetEditButton: UIButton!
    @IBOutlet weak var budgetAmountLabel: UILabel!
    @IBOutlet weak var addWishlistItemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBudgetVC = AddBudgetViewController()
        addBudgetVC.delegate = self
        updateViews()
    }
    
    func updateViews() {
        let budgetValue = UserDefaults.standard.double(forKey: "budgetTotal")
        budgetAmountLabel.text = budgetValue > 0.0 ? currencyFormatter.string(from: NSNumber(value: budgetValue)) : "$0.00"
    }
    


     // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "AddToSettingsSegue" {
            guard let addBudgetVC = segue.destination as? AddBudgetViewController else { return }
            addBudgetVC.delegate = self
        }
    }
}

extension SettingsViewController: addBudgetViewControllerDelegate {
    func budgetHasBeenUpdated() {
        budgetHasBeenSet = true
        
    }
}


