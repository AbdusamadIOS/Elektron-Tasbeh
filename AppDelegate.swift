//
//  AppDelegate.swift
//  Elektron Tasbeh
//
//  Created by Abdusamad Mamasoliyev on 27/05/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()

        let vc = MainVC(nibName: "MainVC", bundle: nil)
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()

        return true
    }


}

