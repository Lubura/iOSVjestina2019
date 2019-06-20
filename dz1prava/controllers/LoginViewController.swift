//
//  LoginViewController.swift
//  dz1prava
//
//  Created by FIVE on 23/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logirajButton: UIButton!
    
    let defaults = UserDefaults.standard
    let url = "https://iosquiz.herokuapp.com/api/session"
    
    
    @IBAction func logiraj(_ sender: UIButton) {
        
        
        if let username = usernameField.text, let password = passwordField.text {
            LoginService().fetchLogin(username: username, password: password, url: url) {
                (response) in
                DispatchQueue.main.async {
                    if let response = response{
                        let token = response["token"] as? String
                        let userId = response["user_id"] as? Int
                        
                        self.defaults.set(token, forKey: "token")
                        self.defaults.set(userId, forKey: "id")
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.prikaziKvizove()
                    }else{
                        print("error")
                    }
                }
            
            }
        } else{
            print("neispravan username ili password!!")
        }
        
    
    }
        
        
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func loggedIn()-> Bool {
        if let token = self.defaults.string(forKey: "token"){
            return true
        }else{
            return false
        }
        
        
    }


    
}
