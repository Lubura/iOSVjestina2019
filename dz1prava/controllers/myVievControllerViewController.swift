//
//  myVievControllerViewController.swift
//  dz1prava
//
//  Created by FIVE on 11/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class myVievControllerViewController: UIViewController {
    
    @IBOutlet weak var funfact: UILabel!
    @IBOutlet weak var naslov: UILabel!
    
    @IBOutlet weak var slikaKviza: UIImageView!
    @IBOutlet weak var dohvati: UIButton!
    @IBOutlet weak var containerCustomView: UIView!
    
    @IBOutlet weak var errorMessage: UILabel!
    
  //  self.errorMessage.isHidden = true
    
    @IBAction func klikGumba(_ sender: UIButton) {
        fetchQuizzes()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
    func fetchQuizzes(){
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        
        let quizService = QuizService()
        
        quizService.fetchQuizzes(urlString: urlString){ (quizzes) in
            if let quizzes = quizzes {
                
                
                let rand = Int(arc4random_uniform(3))
                let quiz = quizzes[rand]
                
                //dohvacanje slike kviza
                if let imageURLString = quiz.image {
                    let imgService = QuizImageService()
                    imgService.fetchQuizImg(urlString: imageURLString) {
                        (image) in
                        DispatchQueue.main.async {
                            self.slikaKviza.image = image
                            if let category = quiz.category{
                                self.slikaKviza.backgroundColor = category.color
                            }
                        }
                        
                    }
                }
                
                DispatchQueue.main.async{
                    
                    self.naslov.text = "\(quiz.title)"
                    if let category = quiz.category{
                        self.naslov.backgroundColor = category.color
                    }
                    
                    
                    
                    
                  

                    
                    if let questionView = Bundle.main.loadNibNamed("QuestionView", owner: nil, options: [:])?.first as? QuestionView {
                        questionView.frame = self.containerCustomView.bounds
                        print(questionView.frame)
                        print(self.containerCustomView.frame)
                        questionView.question = quiz.questions.first! //
                        
                        self.containerCustomView.addSubview(questionView)
                        
                        
                        
                    }
                }
                
                
            }//if quiz
            
          
            }
          
            
            
        }
        
        
        
    
    
    


}


