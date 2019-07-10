//
//  ListaKvizovaViewController.swift
//  dz1prava
//
//  Created by FIVE on 20/05/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class ListaKvizovaViewController: UIViewController {
    
    
    
    @IBOutlet weak var listaKvizovaTable: UITableView!
    
    
    let cellReuseId = "garbageReuseID"
    
    var quizzes : [Quiz]?
    
    var sportQuizzes = [Quiz]()
    var scienceQuizzes = [Quiz]()
    var sections : [[Quiz]]?
    
    
    var refreshControl : UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchQuizzes()
        postaviTablicu()
        
        
    }
    
    func fetchQuizzes(){
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        
       // dohvacanje iz baze
        DispatchQueue.main.async{
            self.quizzes = DataController.shared.fetchQuizzes(nil)
            print(self.quizzes!.count)
            self.refresh()
            self.razvrstajKvizove()
        }
        //dohvacanje s interneta
        QuizService().fetchQuizzes(urlString: urlString){ [weak self] (quizzes) in
            DispatchQueue.main.async{
                
                if let quizzes = quizzes {
                    self?.sportQuizzes.removeAll()
                    self?.scienceQuizzes.removeAll()
                    self?.quizzes = quizzes
                    DataController.shared.saveContext()
                    self?.refresh()
                    self?.razvrstajKvizove()
                }
                
                
            }
        }
    }
    
    func postaviTablicu(){
        listaKvizovaTable.backgroundColor = UIColor.lightGray
        listaKvizovaTable.delegate = self
        listaKvizovaTable.dataSource = self
        listaKvizovaTable.separatorStyle = .none
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        listaKvizovaTable.refreshControl = refreshControl
        
        listaKvizovaTable.register(UINib(nibName: "QuizTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseId)
        
        
        
    }
    
    @objc func refresh(){
        DispatchQueue.main.async {
            self.listaKvizovaTable.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    
    func quiz(_ indexPath: IndexPath) -> Quiz?{
        guard let sections = self.sections else {
            return nil
        }
        
        return sections[indexPath.section][indexPath.row]
    }
    
    func brojKvizovaIsteKategorije(section: Int) -> Int {
        if let sections = self.sections {
            return sections[section].count
        }else{return 0}
    }
    
    func razvrstajKvizove(){
        if let quizzes = self.quizzes{
            
            
            quizzes.map{
                if($0.category == Category.sports.rawValue){
                    self.sportQuizzes.append($0)
                }else{
                    self.scienceQuizzes.append($0)
                }
            }
            
            self.sections = [sportQuizzes, scienceQuizzes]
        }
    }
    
    func categoryForSection(at section: Int) -> Category? {
        if let sections = self.sections {
            return Category( rawValue:sections[section][0].category!)
        }else{
            return nil
        }
    }
}

extension ListaKvizovaViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let category = categoryForSection(at: section){
            let view = TableSectionHeaderView(frame : CGRect(x: 0, y: 0, width:   self.listaKvizovaTable.frame.width, height: 50.0))
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

extension ListaKvizovaViewController : UITableViewDataSource {
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
        return self.sections?.count ?? 0
    }
    
    
    
}
