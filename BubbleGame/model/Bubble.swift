//
//  Bubble.swift
//  BubbleGame
//
//  Created by Jeremy Yang on 24/4/21.
//

import UIKit

class Bubble: UIButton {
    var value: Double = 0
    var radius: UInt32 {
        return UInt32(UIScreen.main.bounds.width / 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = CGFloat(radius)
        
        let possibility = Int(arc4random_uniform(100))
        switch possibility {
        case 0...39:
            self.backgroundColor = .red
            self.value = 1
        case 40...69:
            self.backgroundColor = .systemPink
            self.value = 2
        case 70...84:
            self.backgroundColor = .green
            self.value = 5
        case 85...94:
            self.backgroundColor = .blue
            self.value = 8
        case 95...99:
            self.backgroundColor = .black
            self.value = 10
        default: print("error")
        }
    }
    
    func animation() {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        
        layer.add(springAnimation, forKey: nil)
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
}

}
