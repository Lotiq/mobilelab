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
        subscribeToKeybordNotifications()
        updateImage(name: imageNameArray[currentImage])
        moodTextField.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func addMoodPressed(_ sender: UIButton) {
        let dateString = NSDate().description
        
        // Pass back data.
        let mood = Mood(imageName: imageNameArray[currentImage],message: moodTextField.text ?? "", date: dateString)
        print("called here")
        didSaveMood?(mood)
        navigationController?.popViewController(animated: true)
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
    
    // MARK: Keyboard Modifications
    
    func subscribeToKeybordNotifications(){
        
        //Initiation of notification observation
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        
        //sets y-coordinate of the view above the keyboard if bottom text is selected
        view.frame.origin.y = moodTextField.isFirstResponder ? -getKeyboardHeight(notification) : 0
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        //Gets keyboard height
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        //Removes this control view as observer for notifications
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}
