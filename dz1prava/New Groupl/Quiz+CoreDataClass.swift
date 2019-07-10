//
//  Quiz+CoreDataClass.swift
//  dz1prava
//
//  Created by FIVE on 22/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//
//

import Foundation
import CoreData

//@objc(Quiz)
public class Quiz: NSManagedObject {
    
    
    class func makeFrom(jsonn: [String: Any]) -> Quiz?{
        if
            let id = jsonn["id"] as? Int,
            let title = jsonn["title"] as? String,
            let description = jsonn["description"] as? String,
            let category = jsonn["category"]  as? String,
            let level = jsonn["level"] as? Int,
            let imageURL = jsonn["image"] as? String,
            let questions = jsonn["questions"] as? [Any]{
            
            
            if let quiz = Quiz.firstOrCreate(withTitle: title){
                quiz.id = Int16(id)
                quiz.title = title
                quiz.descripto = description
                quiz.category = category
                quiz.level = Int16( level)
                quiz.image = imageURL
                
                
                for question in questions{
                    if let quest = question as? [String: Any] ,
                        let realQuest = Question.makeFrom(jsonn: quest){
                        quiz.addToQuestions( realQuest )
                    } else{return nil}
                }
                return quiz
                
            } else{ return nil}
        } else {return nil}
    }
    
    class func firstOrCreate(withTitle title: String) -> Quiz? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
        request.returnsObjectsAsFaults = false
        
        do {
            let quizzes = try context.fetch(request)
            if let quiz = quizzes.first {
                return quiz
            } else {
                let newQuiz = Quiz(context: context)
                return newQuiz
            }
        } catch {
            return nil
        }
    }
    
}
