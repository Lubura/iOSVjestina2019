//
//  TableSectionHeaderView.swift
//  dz1prava
//
//  Created by FIVE on 07/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class TableSectionHeaderView: UIView {
    
    var labelCategory: UILabel?
    
    var category: Category? {
        didSet{
            postaviKategoriju()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.labelCategory = UILabel(frame: CGRect(x: self.frame.width/2 - 50 , y: self.frame.height/2 - 15  , width: 150, height: 30))
        labelCategory?.textAlignment = NSTextAlignment.left
        self.addSubview(labelCategory!)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
        
    }
    
    func postaviKategoriju(){
        if let category = category{
            self.backgroundColor = category.color
            self.labelCategory?.text = category.rawValue
            
            
            
        }
        
    }
    
}
