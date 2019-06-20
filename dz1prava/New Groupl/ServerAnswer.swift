//
//  ServerAnswer.swift
//  dz1prava
//
//  Created by FIVE on 02/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation

enum ServerAnswer : Int {
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case badRequest = 400
    case ok = 200
    
}
