//
//  AppDelegate.swift
//  DowntownApp
//
//  Created by Aaron Marsh on 9/11/20.
//  Copyright © 2020 Aaron Marsh. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
        IQKeyboardManager.shared.enable = true
        Stripe.setDefaultPublishableKey("pk_test_51EC8ySL8Gx6rf2qzgh8aZ9SeEKhbwKM5yNzkRd05Hak5rjgn5JlUlRwnNuRBDEuAuRHTFGlhgCxQWIW1zPMH77ys004It6mfDQ") 
        // Override point for customization after application launch.
        return true
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


}
