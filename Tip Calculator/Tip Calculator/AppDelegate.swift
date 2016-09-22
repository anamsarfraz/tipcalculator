//
//  AppDelegate.swift
//  Tip Calculator
//
//  Created by Unum Sarfraz on 9/14/16.
//  Copyright © 2016 Unum Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let defaults = NSUserDefaults.standardUserDefaults()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let startInterval = defaults.integerForKey("app_state_interval") ?? Int(NSDate().timeIntervalSince1970)
        let endInterval = Int(NSDate().timeIntervalSince1970)
        
        let keys_to_remove = ["app_state_interval", "current_bill_amount", "selected_tip_percentage", "selected_party_size", "selected_theme"]
        if (endInterval-startInterval >= 600) {
            
            for key in keys_to_remove {
                defaults.removeObjectForKey(key)
            }
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        defaults.setInteger(Int(NSDate().timeIntervalSince1970), forKey: "app_state_interval")
        defaults.synchronize()
        
    }


}

