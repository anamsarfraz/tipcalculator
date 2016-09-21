//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Unum Sarfraz on 9/20/16.
//  Copyright © 2016 Unum Apps. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet var settingsView: UIView!
    
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var segmentValue = defaults.integerForKey("selected_segment")
        segmentValue = segmentValue ?? tipControl.selectedSegmentIndex
        defaults.setInteger(segmentValue, forKey: "selected_segment")
        tipControl.selectedSegmentIndex = segmentValue
        defaults.synchronize()
        // Do any additional setup after loading the view.
    }

    @IBAction func tipControlChanged(sender: AnyObject) {
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "selected_segment")
        defaults.synchronize()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
