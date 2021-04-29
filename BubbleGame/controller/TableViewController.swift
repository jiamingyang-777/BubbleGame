//
//  TableViewController.swift
//  BubbleGame
//
//  Created by Jeremy Yang on 29/4/21.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var rankingDictionary = [String : Double]()
    var previousRankingDictionary: Dictionary? = [String : Double]()
    var sortedHighScoreArray = [(key: String, value: Double)]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sortedHighScoreArray.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScoreTableViewCell
        cell.nameLabel.text = sortedHighScoreArray[indexPath.row].key
        cell.scoreLabel.text = String(sortedHighScoreArray[indexPath.row].value)
        return (cell)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        previousRankingDictionary = UserDefaults.standard.dictionary(forKey: "highscore") as? Dictionary<String, Double>
               if previousRankingDictionary != nil {
                   rankingDictionary = previousRankingDictionary!
                   sortedHighScoreArray = rankingDictionary.sorted(by: {$0.value > $1.value})
               }
    }
    



}
