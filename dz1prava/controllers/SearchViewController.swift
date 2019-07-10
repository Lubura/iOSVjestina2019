//
//  SearchViewController.swift
//  dz1prava
//
//  Created by FIVE on 21/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var listaKvizovaTW: UITableView!
    @IBOutlet weak var pretraziButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    var refreshControl : UIRefreshControl!
    
    let cellReuseId = "garbageReuseID"
    
    var quizzes : [Quiz]?
    
    var sportQuizzes = [Quiz]()
    var scienceQuizzes = [Quiz]()
    var sections = [[Quiz]]()
    
    @IBAction func pretrazi(_ sender: UIButton) {
        DispatchQueue.main.async {
            if var quizzes = self.quizzes{
                quizzes.removeAll()
            }
            self.sportQuizzes.removeAll()
            self.scienceQuizzes.removeAll()
            self.sections.removeAll()
            self.refresh()
        }
        
        
        let text = self.searchTextField.text
        if let txt = text{
            let predikat = NSPredicate(format: "(descripto CONTAINS[c] %@) OR (title CONTAINS[c] %@)" , txt, txt)
            if let quizzes = DataController.shared.fetchQuizzes( predikat){
                DispatchQueue.main.async {
                    self.quizzes = quizzes
                    self.razvrstajKvizove()
                    self.refresh()
                }
            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchQuizzes()
        postaviTablicu()
        
    }
    func postaviTablicu(){
        listaKvizovaTW.backgroundColor = UIColor.lightGray
        listaKvizovaTW.delegate = self
        listaKvizovaTW.dataSource = self
        listaKvizovaTW.separatorStyle = .none
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        listaKvizovaTW.refreshControl = refreshControl
        
        listaKvizovaTW.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseId)
        
        
        
    }
    
    func quiz(_ indexPath: IndexPath) -> Quiz?{
        if  self.sections.count <= 0  {
            return nil
        }
        
        return sections[indexPath.section][indexPath.row]
    }
    
    func categoryForSection(at section: Int) -> Category? {
        if  sections.count > 0{
            return Category(rawValue: sections[section][0].category!)
        }else{
            return nil
        }
    }
    
    
    func brojKvizovaIsteKategorije(section: Int) -> Int {
        if   self.sections.count > 0 {
            return sections[section].count
        }else{return 0}
    }
    
    func razvrstajKvizove(){
        if let quizzes = self.quizzes{
            var sportQuizzes: [Quiz] = []
            var scienceQuizzes: [Quiz] = []
            
            quizzes.map{
                if($0.category == Category.sports.rawValue){
                    sportQuizzes.append($0)
                }else{
                    scienceQuizzes.append($0)
                }
            }
            if sportQuizzes.count > 0{
                if scienceQuizzes.count > 0{
                    self.sections = [sportQuizzes, scienceQuizzes]
                }else{
                    self.sections = [sportQuizzes]
                }
            } else{
                if sportQuizzes.count > 0 {
                    self.sections = [scienceQuizzes]
                }else{
                    self.sections = []
                }
            }
            self.sportQuizzes = sportQuizzes
            self.scienceQuizzes = scienceQuizzes
        }
    }
    
//    func fetchQuizzes(){
//        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
//
//        QuizService().fetchQuizzes(urlString: urlString){ [weak self] (quizzes) in
//            DispatchQueue.main.async{
//                if let quizzess = quizzes{
//                    self?.quizzes = quizzess
//                    self?.razvrstajKvizove()
//                }
//            }
//        }
//    }
    
    @objc func refresh(){
        DispatchQueue.main.async {
            self.listaKvizovaTW.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    
}

extension SearchViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let category = categoryForSection(at: section){
            let view = TableSectionHeaderView(frame : CGRect(x: 0, y: 0, width:   self.listaKvizovaTW.frame.width, height: 50.0))
            view.category = category
            return view
        }
        
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let quiz = self.quiz(indexPath) {
            let singleQuizViewController = KvizUIViewController()
            singleQuizViewController.quiz = quiz
            navigationController?.pushViewController(singleQuizViewController, animated: true)
        }
    }
    
}

extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brojKvizovaIsteKategorije(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseId, for: indexPath) as! QuizTableViewCell
        
        if let quiz = self.quiz(indexPath) {
            cell.setup(withQuiz: quiz)
            return cell
        }
        return QuizTableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    
    
}



