//
//  SettingsViewController.swift
//  dz1prava
//
//  Created by FIVE on 21/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var username: UILabel!
    
    let defaults = UserDefaults.standard
    
    @IBAction func prikaziLogin(_ sender: UIButton) {
        defaults.removeObject(forKey: "token")
        defaults.removeObject(forKey: "id")
        defaults.removeObject(forKey: "username")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = LoginViewController()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.username.text = defaults.string(forKey: "username")
        self.view.backgroundColor = UIColor.lightGray
        
    }


}
