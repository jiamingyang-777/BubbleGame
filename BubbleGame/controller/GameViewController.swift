//
//  GameViewController.swift
//  BubbleGame
//
//  Created by Jeremy Yang on 24/4/21.
//

import UIKit

class GameViewController: UIViewController {
    var myTimer: Timer?
    var bubble = Bubble()
    var bubbleArray = [Bubble]()
    var configRemainingTime = 60
    var configBubbleNumber = 15
    var scoreCount: Double = 0
    var lastBubbleValue: Double = 0
    var playerName: String = ""
    var rankingDictionary = [String : Double]()
    var previousRankingDictionary: Dictionary? = [String : Double]()
    var sortedHighScoreArray = [(key: String, value: Double)]()
    

    var screenWidth: UInt32 {
        return UInt32(UIScreen.main.bounds.width)
    }
    var screenHeight: UInt32 {
        return UInt32(UIScreen.main.bounds.height)
    }
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousRankingDictionary = UserDefaults.standard.dictionary(forKey: "highscore") as? Dictionary<String, Double>
        if previousRankingDictionary != nil {
            rankingDictionary = previousRankingDictionary!
            sortedHighScoreArray = rankingDictionary.sorted(by: {$0.value > $1.value})
        }
        
        
        myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.countRemainingtime()
            self.removeBubble()
            self.bubbleGenerate()
        }
    }
    
    @IBAction func bubblePress(_ sender: Bubble) {
        sender.removeFromSuperview()
        if lastBubbleValue == sender.value {
            scoreCount += sender.value * 1.5
        }
        else {
            scoreCount += sender.value
        }
        lastBubbleValue = sender.value
        currentScore.text = "\(scoreCount)"
        
        if  previousRankingDictionary == nil {
            highScoreLabel.text = "\(scoreCount)"
        } else if sortedHighScoreArray[0].value < scoreCount {
            highScoreLabel.text = "\(scoreCount)"
        } else if sortedHighScoreArray[0].value >= scoreCount {
            highScoreLabel.text = "\(sortedHighScoreArray[0].value)"
        }
    }
    
    func overLappedBubble(bubbleToCreate: Bubble) -> Bool {
        for currentBubbles in bubbleArray {
            if bubbleToCreate.frame.intersects(currentBubbles.frame) {
             return true
            }
        }
        return false
    }
    
    @objc func bubbleGenerate() {
        let numberToCreate = arc4random_uniform(UInt32(configBubbleNumber - bubbleArray.count)) + 1
        var i = 0
        
        while i < numberToCreate {
            bubble = Bubble()
            bubble.frame = CGRect(x: CGFloat(10 + arc4random_uniform(screenWidth - 2 * bubble.radius - 20)), y: CGFloat(160 + arc4random_uniform(screenHeight - 2 * bubble.radius - 180)), width: CGFloat(2 * bubble.radius), height: CGFloat(2 * bubble.radius))
            if !overLappedBubble(bubbleToCreate: bubble) {
                bubble.addTarget(self, action: #selector(bubblePress), for: UIControl.Event.touchUpInside)
                self.view.addSubview(bubble)
                bubble.animation()
                i += 1
                bubbleArray += [bubble]
            }
        }
    }
    
    @objc func removeBubble() {
        var i = 0
        while i < bubbleArray.count {
            if arc4random_uniform(100) < 33 {
                bubbleArray[i].removeFromSuperview()
                bubbleArray.remove(at: i)
                i += 1
            }
        }
    }
    
    @objc func countRemainingtime() {
        timeRemaining.text = "\(configRemainingTime)"
        if (configRemainingTime == 0) {
            myTimer!.invalidate()
            checkHighScoreExistence()
            
            let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
            present(destinationView, animated: true, completion: nil)
        }
        configRemainingTime -= 1
    }
    
    func highScoreRecord() {
        rankingDictionary.updateValue(scoreCount, forKey: "\(playerName)")
        UserDefaults.standard.set(rankingDictionary, forKey: "highscore")
    }
    
    func checkHighScoreExistence() {
        if previousRankingDictionary == nil {
            highScoreRecord()
        } else {
            rankingDictionary = previousRankingDictionary!
            if rankingDictionary.keys.contains("\(playerName)") {
                let currentScore = rankingDictionary["\(playerName)"]!
                if currentScore < scoreCount {
                    highScoreRecord()
                }
            } else {
                highScoreRecord()
            }
        }
    }
    
}
