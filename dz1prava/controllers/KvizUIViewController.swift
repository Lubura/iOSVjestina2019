//
//  KvizUIViewController.swift
//  dz1prava
//
//  Created by FIVE on 20/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class KvizUIViewController: UIViewController {
    
    @IBOutlet weak var quizTittle: UILabel!
    
    @IBAction func prikaziNajboljeRezultate(_ sender: UIButton) {
       print("dovde doslo btn action")
        if let quiz = self.quiz {
            let lb = LeaderBoardViewController()
            lb.quiz_id = Int64(quiz.id)
            self.navigationController?.pushViewController(lb, animated: true)
        }
        
       
        
    }
    
    @IBOutlet weak var startQuiz: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var quizImage: UIImageView!
    
    var quiz : Quiz?
    var nmbrOfCorrect = 0
    var instantQuestion = 0
    var pocetakKviza: Date?
    let postOn = "https://iosquiz.herokuapp.com/api/result"
    
    let defaults = UserDefaults.standard
    
    
    var time : Double?
    var resultCorrectAnsw: Int?
    
    
    
    @IBAction func startDoQuiz(_ sender: UIButton) {
        if let quiz = self.quiz, let questions = Array(quiz.questions) as? [Question]{
            self.scroll.contentSize.width = self.view.frame.width * CGFloat(questions.count)
            self.scroll.contentSize.height = self.scroll.frame.height
            //omoguci ponovno rjesavanje
            //            self.scroll.contentOffset = CGPoint(x: 0, y: 0)
            //            nmbrOfCorrect = 0
            //            instantQuestion = 0
            var i=0
            for question in questions {
                
                if let questionView = Bundle.main.loadNibNamed("QuestionView", owner: nil, options: [:])?.first as? QuestionView {
                    questionView.frame = CGRect(x: CGFloat( i)*self.view.frame.width , y: 0, width: self.view.frame.width, height: scroll.frame.height)
                    questionView.question = question
                    questionView.delegate = self
                    self.scroll.addSubview(questionView)
                }
                i += 1
            }
            
            
        }
        
        self.pocetakKviza = Date()
        
        
        
    }
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popuniView()
        
        
    }
    //    override func viewDidAppear(_ animated: Bool) {
    //        popuniView()
    //    }
    
    func popuniView(){
        if let quiz = self.quiz{
            if let imageUrl = quiz.image {
                QuizImageService().fetchQuizImg(urlString: imageUrl){
                    (image) in
                    DispatchQueue.main.async{
                        self.quizImage.image = image
                    }
                }
                self.quizTittle.text = quiz.title
              
            }
         
        }else{}
        
    }
    
    func zadnjiTapnut(){
        if let pocetakKviza = self.pocetakKviza, let quiz = self.quiz {
            let time = Date().timeIntervalSince(pocetakKviza)
            let resultCorrectAnsw =  self.nmbrOfCorrect
            let userId = defaults.integer(forKey: "id")
            let token = defaults.string(forKey: "token")
            
            print(time)
            print(userId)
            print(resultCorrectAnsw)
            
            if let token = token{
                PostResultservice().postOnServer(url: postOn, quizId: Int(quiz.id), userId: userId, time: time, nmbrOfCorrect: resultCorrectAnsw, token: token)  {
                    (response) in
                    if let response = response{
                        DispatchQueue.main.async{
                            print(response)
                           self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
            
            
        }
        
    }
    
    
    
}
extension KvizUIViewController : QuestionViewProtocolDelegate{
    func buttonTapped(isCorrect: Bool) {
        if let quiz = quiz{
            instantQuestion += 1
            if(isCorrect){
                nmbrOfCorrect += 1
            }
            if (instantQuestion == quiz.questions.count) {
                zadnjiTapnut()
            } else {
                scroll.setContentOffset(CGPoint(x: CGFloat(instantQuestion) * self.view.frame.width, y: 0), animated: true)
            }
            
        }
        
    }
}
