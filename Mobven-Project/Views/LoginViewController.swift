//
//  LoginViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 4.03.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var isShowingKeybord = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        designTextFields(textFields: [phoneNumberTextField])
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tab = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tab)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, ddont do anything
            return
        }
                
        var shouldMoveViewUp = false
                
        let bottomOfTextField = phoneNumberTextField.convert(phoneNumberTextField.bounds, to: self.view).maxY
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

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "VerificationViewController")
        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backButtonTitle = ""
    }
}
