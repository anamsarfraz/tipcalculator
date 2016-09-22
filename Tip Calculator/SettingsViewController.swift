//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Unum Sarfraz on 9/20/16.
//  Copyright © 2016 Unum Apps. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var themeControl: UISegmentedControl!
    @IBOutlet var settingsView: UIView!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var partySizeSlider: UISlider!
    @IBOutlet weak var partySizeLabel: UILabel!

    
    let defaults = NSUserDefaults.standardUserDefaults()
    let themes = [0: UIColor(red:0.924242, green:0.900055, blue:0.880751, alpha: 1), 1: UIColor(white: 0.7, alpha: 1.0)]

    override func viewDidLoad() {
        super.viewDidLoad()

        /* Check and set tip value
         */
        let tipValue = defaults.floatForKey("selected_tip_percentage") ?? tipSlider.value
        defaults.setFloat(tipValue, forKey: "selected_tip_percentage")
        tipSlider.setValue(tipValue, animated: true)
        tipLabel.text = String(format: "%.2f", tipValue)
        
        /* Check and set party size value
        */
        var partySizeValue = defaults.integerForKey("selected_party_size") ?? Int(partySizeSlider.value)
        partySizeValue = partySizeValue >= 1 ? partySizeValue: 1
        defaults.setInteger(partySizeValue, forKey: "selected_party_size")
        partySizeSlider.setValue(Float(partySizeValue), animated: true)
        partySizeLabel.text = String(format: "%d", partySizeValue)

        /* Check and set theme
         */
        let themeValue = defaults.integerForKey("selected_theme") ?? themeControl.selectedSegmentIndex
        defaults.setInteger(themeValue, forKey: "selected_theme")
        themeControl.selectedSegmentIndex = themeValue
        
        defaults.synchronize()
        
        settingsView.backgroundColor = themes[themeValue]
    }

    @IBAction func tipSliderChanged(sender: AnyObject){
        tipLabel.text = String(format: "%.2f", tipSlider.value)
        defaults.setFloat(tipSlider.value, forKey: "selected_tip_percentage")
        defaults.synchronize()
    }
    
    @IBAction func partySizeSliderChanged(sender: AnyObject) {
        let partySize = Int(partySizeSlider.value)
        partySizeLabel.text = String(format: "%d", partySize)
        defaults.setInteger(partySize, forKey: "selected_party_size")
        defaults.synchronize()        
    }
    
    @IBAction func themeControlChanged(sender: AnyObject) {
        defaults.setInteger(themeControl.selectedSegmentIndex, forKey: "selected_theme")
        settingsView.backgroundColor = themes[themeControl.selectedSegmentIndex]
        defaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tipSlider.alpha = 0
        tipSlider.center.x += self.view.bounds.width
        tipLabel.alpha = 0
        tipLabel.center.x += self.view.bounds.width
        partySizeSlider.alpha = 0
        partySizeSlider.center.x -= self.view.bounds.width
        partySizeLabel.alpha = 0
        partySizeLabel.center.x -= self.view.bounds.width
        themeControl.alpha = 0
        themeControl.center.y += self.view.bounds.height
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tipSlider.alpha = 1
        self.tipLabel.alpha = 1
        self.partySizeSlider.alpha = 1
        self.partySizeLabel.alpha = 1
        self.themeControl.alpha = 1

        UIView.animateWithDuration(0.5, animations: {
            self.tipSlider.center.x -= self.view.bounds.width
            self.tipLabel.center.x -= self.view.bounds.width
            self.partySizeSlider.center.x += self.view.bounds.width
            self.partySizeLabel.center.x += self.view.bounds.width

            self.themeControl.center.y -= self.view.bounds.height
            
        })
    }


}
