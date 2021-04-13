//
//  AppDelegate.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, ListCoordinatorInjected {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        listCoordinator.start()
        return true
    }
}

