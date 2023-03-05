//
//  WelcomeViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 4.03.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons(for: [registerButton, loginButton])
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backButtonTitle = ""
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        navigationController?.pushViewController(viewController, animated: true)
        navigationItem.backButtonTitle = ""
    }
    
    func configureButtons(for buttons: [UIButton]) {
        for button in buttons {
            let gradientLayer = CAGradientLayer.gradientLayer(in: button.bounds)
            button.layer.insertSublayer(gradientLayer, at: 0)
            button.cornerRadius = 17.0
            button.layer.masksToBounds = true
        }
    }
}

extension CAGradientLayer {
    static func gradientLayer(in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors()
        layer.frame = frame
        return layer
    }
    
    private static func colors() -> [CGColor] {
        let beginColor = UIColor(named: "Gradient")
        let endColor = UIColor(named: "Purple")
        
        return [beginColor!.cgColor, endColor!.cgColor]
    }
}
