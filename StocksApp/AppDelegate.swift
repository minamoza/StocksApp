//
//  AppDelegate.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 25.05.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)

        window.rootViewController = ModuleBuilder.shared.tabbarController()
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }


}

