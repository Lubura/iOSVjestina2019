//
//  TabBarViewController.swift
//  dz1prava
//
//  Created by FIVE on 21/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = ListaKvizovaViewController()
        let nvc = UINavigationController(rootViewController: vc)
        
        nvc.tabBarItem = UITabBarItem(title: "Kvizovi", image: nil, tag: 0)
        
        let settings = SettingsViewController()
        settings.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 0)
        
        let search = SearchViewController()
        let nvc2 = UINavigationController(rootViewController: search)
        nvc2.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 0)
        
        self.viewControllers = [nvc, nvc2,  settings]
    }
    
    
    
    
    
}
