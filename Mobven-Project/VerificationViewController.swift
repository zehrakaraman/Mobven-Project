//
//  VerificationViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 5.03.2023.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet weak var codeTextField1: UITextField!
    @IBOutlet weak var codeTextField2: UITextField!
    @IBOutlet weak var codeTextField3: UITextField!
    @IBOutlet weak var codeTextField4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        codeTextField1.configure()
        codeTextField2.configure()
        codeTextField3.configure()
        codeTextField4.configure()
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
    }
}

extension UITextField {
    func configure() {
        self.cornerRadius = 17.0
        self.borderStyle = .none
    }
}


