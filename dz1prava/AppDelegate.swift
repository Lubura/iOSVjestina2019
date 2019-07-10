//
//  AppDelegate.swift
//  dz1prava
//
//  Created by FIVE on 11/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    var window: UIWindow?
    
    func prikaziKvizove () {
//        let vc = ListaKvizovaViewController()
//        let nc = UINavigationController(rootViewController: vc)
        
        
        self.window?.rootViewController = TabBarViewController()
      //  self.window?.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let loginvc = LoginViewController()
        if (!loginvc.loggedIn()){
            self.window?.rootViewController = loginvc
        } else{
           prikaziKvizove()
        }
        
        
        self.window?.makeKeyAndVisible()
        
        return true
        
    }
}




