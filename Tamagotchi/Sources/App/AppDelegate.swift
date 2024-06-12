//
//  AppDelegate.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions
        : [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UINavigationBar.appearance().backgroundColor = .tamaBackground
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.tamaForeground
        ]
        UINavigationBar.appearance().barTintColor = .tamaForeground
        UIViewController.defaultUISwizzle()
        return true
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
    
    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
    }
}
