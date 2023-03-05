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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField()
        
        let tab = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tab)
    }
    
    func configureTextField() {
        phoneNumberTextField.cornerRadius = 17.0
        phoneNumberTextField.borderStyle = .none
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
