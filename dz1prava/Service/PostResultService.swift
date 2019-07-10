//
//  PostResultService.swift
//  dz1prava
//
//  Created by FIVE on 02/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

class PostResultservice {
    
    func postOnServer(url: String, quizId : Int, userId: Int, time: Double, nmbrOfCorrect: Int , token : String, completion : @escaping (ServerAnswer?) -> Void) {
        
        
        if let urll = URL(string: url){
            
            var request = URLRequest(url: urll)
            request.addValue(token, forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
            request.httpMethod = "POST"
            
            let parametri: [String : Any] = [
                "quiz_id" : quizId ,
                "user_id" : userId,
                "time" : time,
                "no_of_correct" : nmbrOfCorrect
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject:
                    parametri , options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse{
                    
                    completion(ServerAnswer.init(rawValue: response.statusCode ))
                    
                    
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

