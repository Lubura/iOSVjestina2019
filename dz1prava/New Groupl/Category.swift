//
//  Category.swift
//  dz1prava
//
//  Created by FIVE on 11/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation
import UIKit

enum Category: String {
    
    case sports = "SPORTS"
    case science = "SCIENCE"
    
    var color : UIColor {
        switch self{
        case .sports :
            return UIColor.blue
        case .science:
            return UIColor.brown
        }
    }
    
}
