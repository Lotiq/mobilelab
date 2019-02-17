//
//  ViewController.swift
//  Catch Me If You Can
//
//  Created by Timothy on 2/3/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rulesLabel: UILabel!
    
    var gameStarted = false
    var buttonImages = ["Bird","Snail","Rabbit","Squirrel","Vader"]
    var chosenImage = String()
    var currentImage = String()
    var count = 1
    var time = 60
    var gameTimer = Timer()
    var trapTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewTarget()
    }
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        if gameStarted == true {
            if (currentImage == chosenImage){
                updateCount()
            } else {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                trapTimer.invalidate()
                gameOver("You fell for the trap!")
                
            }
        } else {
            time = 60
            count = 1
            timeLabel.text = "Time: " + String(time)
            countLabel.text = "Count: 1"
            gameLabels(enabled: true)
            gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        }
    }
    
    func gameOver(_ reason: String){
        gameTimer.invalidate()
        
        let alert = UIAlertController(title: "Game Over", message: reason, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        gameLabels(enabled: false)
        setNewTarget()
        countLabel.text = "Your Score: " + String(count)
    }
    
    func updateCount(_ points: Int = 1){
        count+=points
        countLabel.text = "Count: " + String(count)
        
        if arc4random_uniform(100)<25{
            currentImage = buttonImages.randomElement()!
            gameButton.setImage(UIImage(named: currentImage), for: .normal)
            if (currentImage != chosenImage){
                trapTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.removeTrap), userInfo: nil, repeats: false)
            }
        } else {
            currentImage = chosenImage
            gameButton.setImage(UIImage(named: currentImage), for: .normal)
        }
    }
    
    @objc func removeTrap(){
        if gameStarted == true {
            updateCount(3)
        }
    }
    
    @objc func updateTime(){
        time-=1
        if (time >= 0) {
            timeLabel.text = "Time: " + String(time)
        } else {
            gameOver("Time's Up!")
        }
    }
    
    func gameLabels(enabled: Bool){
        gameStarted = enabled
        timeLabel.isHidden = !enabled
        rulesLabel.isHidden = enabled
    }
    
    func setNewTarget(){
        chosenImage = buttonImages.randomElement()!
        currentImage = chosenImage
        gameButton.setImage(UIImage(named: chosenImage), for: .normal)
    }
    
}

