//
//  ViewController.swift
//  Unlock_Me
//
//  Created by Timothy on 2/9/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    
    
    var attempts = 3;
    var passColor = (0.63...0.75,0.27...0.39, 0.88...1);
    var lockTimer = Timer();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateColor()
        statusLabel.text = "Enter color"
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        updateColor()
    }
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        if (unlockButton.titleLabel?.text == "Unlock"){
            if (passColor.0 ~= Double(rSlider.value) && passColor.1 ~= Double(gSlider.value) && passColor.2 ~= Double(bSlider.value) ){
                statusLabel.text = "Unlocked Successfully!"
                unlockButton.setTitle("Lock", for: .normal)
            } else {
                attempts-=1
                statusLabel.text = "Failed: \(attempts) Attempts Left"
                if (attempts <= 0){
                    unlockButton.isEnabled = false
                    lockTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.removeLock), userInfo: nil, repeats: false)
                    statusLabel.text = "All Attempts Failed!"
                }
                
            }
        } else {
            passColor = (Double(rSlider.value)-0.06...Double(rSlider.value)+0.06,Double(gSlider.value)-0.06...Double(gSlider.value)+0.06,Double(bSlider.value)-0.06...Double(bSlider.value)+0.06)
            unlockButton.setTitle("Unlock", for: .normal)
            attempts = 3;
            statusLabel.text = "3 Attempts Left"
        }
    }
    
    @objc func removeLock(){
        unlockButton.isEnabled = true
        attempts = 3
        statusLabel.text = "3 Attempts Left"
    }
    
    func updateColor(){
        let values = (CGFloat(rSlider.value),CGFloat(gSlider.value),CGFloat(bSlider.value));
        
        rSlider.thumbTintColor = UIColor(red: values.0, green: values.1, blue: values.2, alpha: 1)
        gSlider.thumbTintColor = UIColor(red: values.0, green: values.1, blue: values.2, alpha: 1)
        bSlider.thumbTintColor = UIColor(red: values.0, green: values.1, blue: values.2, alpha: 1)
    }
}

