//
//  LoginService.swift
//  dz1prava
//
//  Created by FIVE on 29/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation


class LoginService {
    
    func fetchLogin(username: String, password : String, url: String , completion : @escaping ([String: Any]?) -> Void){
        
        
        if let urll = URL(string: url){
            
            var request = URLRequest(url: urll)
            request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
            request.httpMethod = "POST"
            
            let parametri: [String : String?] = [
                "username" : username ,
                "password" : password
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject:
                    parametri , options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                
                if let data = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonDict = json as? [String : Any]
                        {
                            completion(jsonDict)
                        } else{
                            completion(nil)
                        }
                        
                    }
                    catch{}
                }else{
                    completion(nil)
                }
                
                
            }
            dataTask.resume()
            
            
        }else{
            completion(nil)
        }
        
    }
}
