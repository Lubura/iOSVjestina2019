//
//  LeaderBoardViewController.swift
//  dz1prava
//
//  Created by FIVE on 21/06/2019.
//  Copyright © 2019 FIVE. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {
    
    @IBOutlet weak var tablicaRezultata: UITableView!
    
    var usernames : [String] = []
    var scores : [String] = []
    
    var refreshControl : UIRefreshControl!
    
    var quiz_id : Int64?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dohvatiPodatke()
        postaviTablicu()
    }
    
    func postaviTablicu() {
        tablicaRezultata.backgroundColor = UIColor.lightGray
        tablicaRezultata.delegate = self
        tablicaRezultata.dataSource = self
        tablicaRezultata.separatorStyle = .none
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        tablicaRezultata.refreshControl = refreshControl
    }
    
    @objc func refresh(){
        DispatchQueue.main.async {
            self.tablicaRezultata.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func dohvatiPodatke(){
        if let quizID = quiz_id {
            let url = "https://iosquiz.herokuapp.com/api/score?quiz_id=" + String(quizID)
            print("pocelo fetch")
            LeaderBoardService().fetchTheBestResults(url: url, quizId: Int(quizID)) {
                (results) in
                DispatchQueue.main.async {
                    
                    for i in 0...20 {
                        if let resultss = results, let result = resultss[i] as? [String : Any] {
                            print(result)
                            self.usernames.append(result["username"] as? String ?? "" )
                            self.scores.append(result["score"] as? String ?? "")
                        }
                    }
                    self.refresh()
                    
                 
                }
                
                
            }
        }
    }
    
    
    
}
extension LeaderBoardViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}


extension LeaderBoardViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        if (self.usernames.count > 0 && self.scores.count > 0) {
            cell.textLabel?.text = usernames[indexPath.row]
            cell.detailTextLabel?.text = scores[indexPath.row]
        }
        return cell
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}
