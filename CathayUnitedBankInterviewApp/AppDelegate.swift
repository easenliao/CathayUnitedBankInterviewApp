//
//  AppDelegate.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = UINavigationController(rootViewController: TabBarViewController())
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}
