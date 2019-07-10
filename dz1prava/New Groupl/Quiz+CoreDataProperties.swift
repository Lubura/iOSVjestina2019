//
//  Quiz+CoreDataProperties.swift
//  dz1prava
//
//  Created by FIVE on 10/07/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//
//

import Foundation
import CoreData


extension Quiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }

    @NSManaged public var category: String?
    @NSManaged public var descripto: String?
    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var level: Int16
    @NSManaged public var title: String?
    @NSManaged public var questions: NSSet

}

// MARK: Generated accessors for questions
extension Quiz {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Question)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Question)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
