//
//  TheBestResultsService.swift
//  dz1prava
//
//  Created by FIVE on 21/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

class LeaderBoardService {
    let defaults = UserDefaults.standard
    
    func fetchTheBestResults(url: String, quizId: Int, completion : @escaping (NSArray?) -> Void){
        
        if let urll = URL(string: url), let token = self.defaults.string(forKey: "token") {
            
            var request = URLRequest(url: urll)
            request.addValue(token, forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
            request.httpMethod = "GET"
    
            print("nova provjera")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let dataa = data {
                    
                    do{
                        let jsonn = try JSONSerialization.jsonObject(with: dataa, options: [])
                        if let rez = jsonn as? NSArray {
                            
                            
                            completion(rez)
                            
                        }
                        
                        
                    }catch{
                        completion(nil)
                    }
                }else{
                    completion(nil)
                }
                
            }
            dataTask.resume()
            
            
        } else {
            completion(nil)
        }
    }
    
    
}
