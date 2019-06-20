//
//  CustomView.swift
//  dz1prava
//
//  Created by FIVE on 11/04/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

public protocol QuestionViewProtocolDelegate: NSObjectProtocol {
    func buttonTapped(isCorrect : Bool)
}

class QuestionView: UIView {
    
    weak var delegate: QuestionViewProtocolDelegate?
    
    var question : Question? {
        didSet {
            updateView()
        }
    }
    var correctAnswer : Int?
    
    @IBOutlet weak var pitanje: UILabel!
    
    @IBOutlet weak var answ1: UIButton!
    @IBOutlet weak var answ2: UIButton!
    @IBOutlet weak var answ3: UIButton!
    @IBOutlet weak var answ4: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func updateView(){
        if let question = self.question{
            
        
        self.correctAnswer = question.correctAnswer
        let answers = question.answers
        
        self.pitanje.text = question.question
        
        self.answ1.setTitle(answers[0], for: .normal)
        self.answ2.setTitle(answers[1], for: .normal)
        self.answ3.setTitle(answers[2], for: .normal)
        self.answ4.setTitle(answers[3], for: .normal)
        }
    }
    
    
    @IBAction func klikA(_ sender: UIButton) {
        self.answ1.backgroundColor =  self.kojiTocan( brojGumba : 0)
        
        delegate?.buttonTapped(isCorrect: isCorrect(nmbrOfButton: 0))
        
    }
    
    @IBAction func klikB(_ sender: UIButton) {
       self.answ2.backgroundColor =  self.kojiTocan( brojGumba :1)
        delegate?.buttonTapped(isCorrect: isCorrect(nmbrOfButton: 1))
    }
    
    
    @IBAction func klikC(_ sender: Any) {
        self.answ3.backgroundColor = self.kojiTocan( brojGumba : 2)
        delegate?.buttonTapped(isCorrect: isCorrect(nmbrOfButton: 2))
    }
    
    @IBAction func klikD(_ sender: UIButton) {
        self.answ4.backgroundColor = self.kojiTocan(brojGumba : 3)
        delegate?.buttonTapped(isCorrect: isCorrect(nmbrOfButton: 3))
    }
    
    func kojiTocan(brojGumba : Int) -> UIColor{
        if(brojGumba == self.correctAnswer){
            return UIColor.green
        }else{
            return UIColor.red
        }
    }
    func isCorrect(nmbrOfButton: Int) -> Bool {
        if(nmbrOfButton == self.correctAnswer){
            return true
        }else {
            return false
        }
    }
    
    
}
