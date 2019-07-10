//
//  DataController.swift
//  dz1prava
//
//  Created by FIVE on 21/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    static let shared = DataController() //singleton
    private init (){}

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "dataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func fetchQuizzes(_ predikat: NSPredicate?)-> [Quiz]?{
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.predicate = predikat
        
        let context = DataController.shared.persistentContainer.viewContext
        
        let quizzes = try? context.fetch(request)
        return quizzes
    }
    
    func saveContext(){
     
        if self.context.hasChanges {
            do{
                try self.context.save()
            } catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}
