//
//  Question+CoreDataProperties.swift
//  dz1prava
//
//  Created by FIVE on 10/07/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var correctAnsw: Int16
    @NSManaged public var id: Int16
    @NSManaged public var quest: String?
    @NSManaged public var answers: [String]
    @NSManaged public var quizOwner: Quiz?

}
