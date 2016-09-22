//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Unum Sarfraz on 9/14/16.
//  Copyright © 2016 Unum Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet var tipView: UIView!
    @IBOutlet weak var paramView: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var partySizeLabel: UILabel!
    @IBOutlet weak var individualShareLabel: UILabel!
    

    let defaults = NSUserDefaults.standardUserDefaults()
    var currencySymbol: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        /* Create a shadow effect
         */
        paramView.layer.shadowColor = UIColor.blackColor().CGColor
        paramView.layer.shadowOffset = CGSizeZero
        paramView.layer.shadowOpacity = 0.5
        paramView.layer.shadowRadius = 5

        resultView.layer.shadowColor = UIColor.blackColor().CGColor
        resultView.layer.shadowOffset = CGSizeZero
        resultView.layer.shadowOpacity = 0.5
        resultView.layer.shadowRadius = 5
      
        /* Get and use the currency symbol
         */
        currencySymbol = getCurrencySymbol()
        billField.placeholder = currencySymbol
        let bill = defaults.doubleForKey("current_bill_amount") ?? 0.00

        if (bill > 0.00) {
            billField.text = formatNumber(bill)
        }
        
        /* calculate tip on existing values
         */
        calculateTip()
        /* Bill field is first responder when view
           loads
         */
        billField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTip() {
        var billAmount = billField.text! ?? ""
        if (billAmount.characters.count > 1 && billAmount.characters.first == currencySymbol.characters.first) {
            let index = billAmount.startIndex.advancedBy(1)
            billAmount = billAmount.substringFromIndex(index)
        }
        
        var bill = Double(billAmount) ?? 0.00
        if (bill < 0.00) {
            bill = 0.00
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var selectedTip = defaults.floatForKey("selected_tip_percentage")
        selectedTip = Float(String(format: "%.2f", selectedTip ?? 0.0))!
        var selectedPartySize = defaults.integerForKey("selected_party_size")
        selectedPartySize = selectedPartySize >= 1 ? selectedPartySize: 1
        
        let tip = bill * Double(selectedTip)
        let total = bill + tip
        let individualShare = total/Double(selectedPartySize)
        
        // Display the calculated values
        partySizeLabel.text = String(format: "%d", selectedPartySize)
        tipPercentageLabel.text = String(format: "%.2f%%", selectedTip*100)
        tipLabel.text = formatNumber(tip)
        totalLabel.text = formatNumber(total)
        individualShareLabel.text = formatNumber(individualShare)
        
        defaults.setDouble(bill, forKey: "current_bill_amount")
        defaults.synchronize()
    }

    func getCurrencySymbol() -> String {
        let locale = NSLocale.currentLocale()
        return locale.objectForKey(NSLocaleCurrencySymbol) as! String
    }
    
    func formatNumber(amount: Double) -> String{
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = 2
        return formatter.stringFromNumber(amount)!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.billField.alpha = 0
        self.partySizeLabel.alpha = 0
        self.tipPercentageLabel.alpha = 0
        self.tipLabel.alpha = 0
        self.totalLabel.alpha = 0
        self.individualShareLabel.alpha = 0
        
        /* Check and set theme
         */
        let themeValue = defaults.integerForKey("selected_theme") ?? 0
        let s = SettingsViewController()
        tipView.backgroundColor = s.themes[themeValue]
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5, animations: {
            // This causes first view to fade in and second view to fade out
            self.billField.alpha = 1
            self.partySizeLabel.alpha = 1
            self.tipPercentageLabel.alpha = 1
            self.tipLabel.alpha = 1
            self.totalLabel.alpha = 1
            self.individualShareLabel.alpha = 1

        })
        calculateTip()
    }
        
    @IBAction func onScreenTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

