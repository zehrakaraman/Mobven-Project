//
//  LoginViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 4.03.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    var constraint: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureTextField([phoneNumberTextField])
        configureLabel()
        phoneNumberTextField.addTarget(self, action: #selector(nextPage), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
//        let termsTap = UITapGestureRecognizer(
//            target: self,
//            action: #selector(tappedOnLabel))
//        termsTap.numberOfTapsRequired = 1
//        view.addGestureRecognizer(termsTap)
    }
    
    func configureLabel() {
        if let fullText = termsLabel.text {
            self.termsLabel.changeColorText(fullText: fullText, changeText: "Terms and Condition")
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if termsLabel.frame.origin.y != keyboardSize.height {
                constraint = termsLabel.frame.origin.y - keyboardSize.origin.y
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    self.topConstraint.constant -= (self.constraint + self.termsLabel.frame.height + 10)
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.topConstraint.constant += (self.constraint + self.termsLabel.frame.height + 10)
                self.view.layoutIfNeeded()
                self.dismissKeyboard()
            })
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.termsLabel.text else { return }
        let termsAndConditionRange = (text as NSString).range(of: "Terms and Condition")
        if gesture.didTapAttributedTextInLabel(label: termsLabel, inRange: termsAndConditionRange) {
            print("Tapped terms and condition")
        }
    }
    
    @objc func nextPage(_ textField: UITextField) {
        if textField.text?.count == 11 {
            dismissKeyboard()
            nextButtonTapped(nextButton)
        }
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if phoneNumberTextField.text?.count == 11 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "VerificationViewController")
            navigationController?.pushViewController(viewController, animated: true)
            navigationItem.backButtonTitle = ""
        } else {
            print("Missing content")
        }
        
    }
}
