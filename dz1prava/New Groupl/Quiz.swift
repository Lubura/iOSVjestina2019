//
//  quiz.swift
//  dz1prava
//
//  Created by FIVE on 11/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation
import UIKit

class Quiz{
    
    var id : Int
    var title : String
    var description: String
    var questions: [Question] = []
    var category: Category?
    var level : Int
    var image : String?
    
    
    
    init?(oneQuiz: Any) {
        print(oneQuiz)
        
        if let quizz = oneQuiz as? [String : Any],
        let id = quizz["id"] as? Int,
        let title = quizz["title"] as? String,
        let description = quizz["description"] as? String,
        let category = quizz["category"]  as? String,
        let level = quizz["level"] as? Int,
        let imageURL = quizz["image"] as? String,
        let questions = quizz["questions"] as? [Any]{
            self.id = id
            self.title = title
            self.level = level
            self.description = description
            self.image = imageURL
            
            //dohvacanje slike
            
           
            
            if let categoryy = Category.init(rawValue: category){
               self.category = categoryy
            }
            
            for question in questions{
                if let questDict = question as? [String : Any],
                let idd = questDict["id"] as? Int,
                let quest = questDict["question"] as? String,
                let answerss = questDict["answers"] as? [String],
                    let correct = questDict["correct_answer"] as? Int {
                    let oneQuestion = Question(id: idd, question: quest, answers: answerss, correctAnswer: correct)
                    self.questions.append(oneQuestion)
                  }
            }
        } else{
            return nil
        }
    }
}
