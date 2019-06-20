//
//  Question.swift
//  dz1prava
//
//  Created by FIVE on 11/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

class Question{
    
    
    let id: Int
    let question: String
    let answers: [String]
    let correctAnswer: Int
    
    init(id : Int, question : String, answers : [String], correctAnswer : Int) {
        self.id = id
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
    
    
    
}
