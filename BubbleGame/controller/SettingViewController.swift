//
//  SettingViewController.swift
//  BubbleGame
//
//  Created by Jeremy Yang on 24/4/21.
//

import UIKit

class SettingViewController: UIViewController {
    var timeSliderValue = 60
    var numberSliderValue = 15
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var playerNameField: UITextField!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var bubbleSlider: UISlider!
    
    @IBAction func timeSliderChange(_ sender: UISlider) {
        let durationSliderValue = Int(sender.value)
        timeLabel.text = "\(durationSliderValue)"
    }
    @IBAction func numberSliderChange(_ sender: UISlider) {
        let bubbleSliderValue = Int(sender.value)
        numberLabel.text = "\(bubbleSliderValue)"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameTimer = Int(timeSlider.value)
        let bubbleNumber = Int(bubbleSlider.value)
        if segue.identifier == "gameSegue" {
            let VC = segue.destination as! GameViewController
            VC.playerName = playerNameField.text!
            VC.configRemainingTime = gameTimer
            VC.configBubbleNumber = bubbleNumber
        }
    }
    

}


