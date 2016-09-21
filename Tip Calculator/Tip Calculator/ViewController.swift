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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTip() {
        let tipPercentages = [0.18, 0.20, 0.25]
        let bill = Double(billField.text!) ?? 0
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var selectedTip = defaults.integerForKey("selected_segment")
        selectedTip = selectedTip ?? 0
        let tip = bill * tipPercentages[selectedTip]
        let total = bill + tip
        
        // Display the calculated values
        tipPercentageLabel.text = String(format: "%d%%", Int(tipPercentages[selectedTip]*100))
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calculateTip()
    }

    @IBAction func onScreenTap(sender: AnyObject) {
        view.endEditing(true)


    }
    
    
}

