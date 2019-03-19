//
//  AppDelegate.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit
import SwiftyBeaver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SetupLogger()
        logger.info("APP STARTED")
                
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        logger.info("APP RESIGN ACTIVE")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        logger.info("APP ENTER BACKGROUND")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        logger.info("APP ENTER FOREGROUND")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        logger.info("APP BECOME ACTIVE")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        logger.info("APP ENDED")
    }
}

