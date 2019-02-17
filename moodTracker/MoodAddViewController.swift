//
//  ModeAddViewController.swift
//  moodTracker
//
//  Created by Timothy on 2/16/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

class MoodAddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var moodTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var imageNameArray: [String] = ["Angry","Happy","Sad","Love","Confused","Cool","Crying","Nervous","Surprised","Calm"]
    var currentImage = 3;
    var didSaveMood: ((_ mood: Mood) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateImage(name: imageNameArray[currentImage])
        moodTextField.text = ""
    }
    
    @IBAction func addMoodPressed(_ sender: UIButton) {
        let dateString = NSDate().description
        
        // Pass back data.
        let mood = Mood(imageName: imageNameArray[currentImage],message: moodTextField.text ?? "", date: dateString)
        didSaveMood?(mood)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func swiped(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left){
            // do back
            if (currentImage == 0){
                currentImage = imageNameArray.count-1
            } else {
                currentImage -= 1
            }
            updateImage(name: imageNameArray[currentImage])
        } else if (sender.direction == .right){
            if (currentImage == imageNameArray.count-1){
                currentImage = 0
            } else {
                currentImage += 1
            }
            updateImage(name: imageNameArray[currentImage])
        } else {
            print("Error: ")
        }
    }
    
    func updateImage(name: String){
        moodImageView.image = UIImage(named: name)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
