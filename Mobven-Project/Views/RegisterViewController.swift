//
//  RegisterViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 4.03.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var accountImageButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var isShowingKeybord = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designTextFields(textFields: [nameTextField])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, ddont do anything
            return
        }
                
        var shouldMoveViewUp = false
                
        let bottomOfTextField = nameTextField.convert(nameTextField.bounds, to: self.view).maxY
        let topOfKeyboard = self.view.frame.height - keyboardSize.height
                
        if bottomOfTextField > topOfKeyboard {
            shouldMoveViewUp = true
        }
                
        if shouldMoveViewUp {
            // move to root view up by the distance of keyboard height
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back to root view origin to zero
        dismissKeyboard()
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}

