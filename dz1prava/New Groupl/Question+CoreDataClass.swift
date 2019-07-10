//
//  Question+CoreDataClass.swift
//  dz1prava
//
//  Created by FIVE on 22/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//
//

import Foundation
import CoreData

//@objc(Question)
public class Question: NSManagedObject {
    
    class func firstOrCreate(withQuest quest: String) -> Question? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "quest = %@", quest)
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        request.returnsObjectsAsFaults = false
        
        do {
            let questionss = try context.fetch(request)
            if let question = questionss.first {
                return question
            } else {
                let newQuestion = Question(context: context)
                return newQuestion
            }
        } catch {
            return nil
        }
    }
    
    class func makeFrom(jsonn : [String: Any] ) -> Question? {
        if
            let idd = jsonn["id"] as? Int16,
            let quest = jsonn["question"] as? String,
            let answerss = jsonn["answers"] as? [String],
            let correct = jsonn["correct_answer"] as? Int {
            
          
            
            if let question = Question.firstOrCreate(withQuest : quest){
                question.id = idd
                question.quest = quest
                question.correctAnsw = Int16( correct)
                question.answers = answerss
                
                
                return question
            }else { return nil}
        } else{
            return nil}
    }
}
