//
//  AppDelegate.swift
//  Example
//
//  Created by Danil Gontovnik on 27/06/2016.
//  Copyright © 2016 Kaizen Technologies Ltd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    // MARK: - Vars

    var window: UIWindow?

}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Waymark.setup(self.window?.rootViewController as! UINavigationController)
        Waymark.push(ViewController.self, context: nil, animated: true, completion: nil)
        return true
    }
    
}
