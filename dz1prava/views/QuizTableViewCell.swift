//
//  QuizTableViewCell.swift
//  dz1prava
//
//  Created by FIVE on 20/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var slikaKviza: UIImageView!
    
    @IBOutlet weak var tittleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tezinaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        slikaKviza.image = nil
        tittleLabel.text = ""
        descriptionLabel.text = ""
        tezinaLabel.text = ""
    }
    
    func setup(withQuiz quiz : Quiz){
        if let imageUrl = quiz.image {
            QuizImageService().fetchQuizImg(urlString: imageUrl){
                [weak self] (image) in
                DispatchQueue.main.async{
                    if let imagee = image{
                        self?.slikaKviza.image = imagee
                    }
                }
            }
            
            
        }
        self.tittleLabel.text = quiz.title
        self.descriptionLabel.text = quiz.description
        self.descriptionLabel.lineBreakMode = .byClipping
        self.tezinaLabel.text = String(quiz.level)
        //self.backgroundColor = quiz.category!.color
    }
    
}


