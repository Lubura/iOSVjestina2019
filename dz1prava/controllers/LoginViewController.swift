//
//  LoginViewController.swift
//  dz1prava
//
//  Created by FIVE on 23/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var naslovLabel: UILabel!
    
   
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logirajButton: UIButton!
    
    let defaults = UserDefaults.standard
    let url = "https://iosquiz.herokuapp.com/api/session"
    
    
    @IBAction func logiraj(_ sender: UIButton) {
        
      animiraj()
        
        
        if let username = usernameField.text, let password = passwordField.text {
            LoginService().fetchLogin(username: username, password: password, url: url) {
                (response) in
                DispatchQueue.main.async {
                    if let response = response{
                        let token = response["token"] as? String
                        let userId = response["user_id"] as? Int
                        
                        self.defaults.set(token, forKey: "token")
                        self.defaults.set(userId, forKey: "id")
                        self.defaults.set(username, forKey: "username")
                        
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
        
        naslovLabel.alpha = 0
        
        usernameField.center = CGPoint(x: -(usernameField.frame.width/2), y: usernameField.center.y)
//        usernameField.frame = CGRect(x:  -(usernameField.frame.width + 30), y: usernameField.center.y, width: usernameField.frame.width, height: usernameField.frame.height)
        passwordField.center = CGPoint(x:  -(passwordField.frame.width/2), y: passwordField.center.y)
        logirajButton.center = CGPoint(x: -logirajButton.frame.width/2, y: logirajButton.center.y)
        
    }
    func animiraj (){
        UIView.animate(withDuration: 2, delay:0,  options: UIViewAnimationOptions.curveEaseOut, animations:{
            self.usernameField.transform.ty = self.view.bounds.height
            self.naslovLabel.alpha = 0
            
        }) {
            _ in
        }
        
        
        UIView.animate(withDuration: 2, delay:0.2,  options: UIViewAnimationOptions.curveEaseOut, animations:{
//            self.passwordField.transform = CGAffineTransform(translationX: self.passwordField.frame.origin.x, y: -self.view.bounds.height)
            self.passwordField.transform.ty = self.view.bounds.height
        }, completion: nil)

        UIView.animate(withDuration: 2, delay:0.35,  options: UIViewAnimationOptions.curveEaseOut, animations:{
            self.logirajButton.transform.ty = self.view.bounds.height
        }) {
            _ in
        }
    }
    override func viewDidLayoutSubviews() {
        
        UIView.animate(withDuration: 1, delay:0,  options: UIViewAnimationOptions.curveEaseOut, animations:{
            self.usernameField.transform = CGAffineTransform(translationX: self.usernameField.frame.width + 30, y: 0)
            self.naslovLabel.alpha = 1
            
        }) {
            _ in
        }
        
        UIView.animate(withDuration: 1, delay:0.1,  options: UIViewAnimationOptions.curveEaseOut, animations:{
            self.passwordField.transform = CGAffineTransform(translationX: self.passwordField.frame.width + 30, y: 0)
            
        }) {
            _ in
        }
        
        UIView.animate(withDuration: 1, delay:0.35,  options: UIViewAnimationOptions.curveEaseOut, animations:{
            if let widthEkran = UIApplication.shared.keyWindow?.frame.width {
                 self.logirajButton.transform = CGAffineTransform(translationX: self.logirajButton.frame.width/2 + widthEkran/2 , y: 0)
            }
           
            
        }) {
            _ in
        }
        
    }
    
   
    
    func loggedIn()-> Bool {
        if let token = self.defaults.string(forKey: "token"){
            return true
        }else{
            return false
        }
        
        
    }


    
}
