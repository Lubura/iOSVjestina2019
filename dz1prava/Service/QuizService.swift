//
//  QuizService.swift
//  dz1prava
//
//  Created by FIVE on 12/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

class QuizService {
    //var arrayQuizzes : [Quiz] = []
    
    func fetchQuizzes(urlString : String, toComplete: @escaping ([Quiz]?) -> Void){
        
        if let urll = URL(string: urlString){
            
            let urlRequest = URLRequest(url: urll)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    do{
                        let jsonn = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonDict = jsonn as? [String : Any],
                            let quizzes = jsonDict["quizzes"] as? [Any]{
                            var lista = [Quiz]()
                            for quiz in quizzes{
                                if let quizz = quiz as? [String: Any],
                                    let realQuiz = Quiz.makeFrom(jsonn: quizz){
                                    lista.append(realQuiz)
                                }
                            }
                            
                            toComplete(lista)
                        }
                        
                    }catch{
                        toComplete(nil)
                    }
                }else{
                    toComplete(nil)
                }
            
        }
            dataTask.resume()
        } else{
            toComplete(nil)
        }
    
    }
    
}
