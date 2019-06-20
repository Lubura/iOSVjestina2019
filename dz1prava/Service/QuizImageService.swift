//
//  QuizImage.swift
//  dz1prava
//
//  Created by FIVE on 12/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import Foundation
import UIKit

class QuizImageService{
    
    func fetchQuizImg(urlString : String,  toComplete: @escaping((UIImage?) -> Void) ){
        
        if let url = URL(string: urlString){
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    toComplete(image)
                }else{
                    toComplete(nil)
                }
            }
            dataTask.resume()
        }else{
            toComplete(nil)
        }
    }
}
