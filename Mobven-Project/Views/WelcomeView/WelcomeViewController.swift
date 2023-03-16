//
//  WelcomeViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 4.03.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerButtonTapped(_ sender: GradientButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backButtonTitle = ""
    }
    
    
    @IBAction func loginButtonTapped(_ sender: GradientButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backButtonTitle = ""
    }
}
