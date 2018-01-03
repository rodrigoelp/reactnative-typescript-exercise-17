//
//  AppDelegate.swift
//  swiftly
//
//  Created by Rodrigo Landaeta on 2/1/18.
//  Copyright © 2018 Rodrigo Landaeta. All rights reserved.
//

import UIKit
import React

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // In here, we need to introduce our code that will load the first UIViewController with our react native view.
        // If you are interested in getting react native to work as a subset of your native application, then this code needs to be moved to the event (outlet or whatever)
        // that will present the view controller.
        // So, let's load the RCTRootView so react native can be set up and calls out javascript code.
        
        // First, we need to locate which version of the javascript code we are going to be using. By default, when building the application as debug
        // the code location is going to be: http://localhost:8081/index.bundle?platform=ios
        // whilst the production or release version is going to be NSBundle(string: "main.bundle")
        let codeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
        // Next... we need to create the window and the react root view hosting the js engine.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootView = RCTRootView(
            bundleURL: codeLocation,
            moduleName: "swiftly", // this name comes from the package.json and AppRegistry.registerComponent("moduleName", ...). It has to match
            initialProperties: nil,
            launchOptions: nil)
        // A view controller to manage the lifecycle of that root view
        let viewController = UIViewController()
        viewController.view = rootView
        self.window?.rootViewController = viewController
        // and we are done. All we need to do now is to make it visible.
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

