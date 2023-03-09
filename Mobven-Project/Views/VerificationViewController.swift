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

        configureTextField([codeTextField1,
                            codeTextField2,
                            codeTextField3,
                            codeTextField4])
        
        codeTextField1.addTarget(self, action: #selector(switchBasedNextTextField), for: .editingChanged)
        codeTextField2.addTarget(self, action: #selector(switchBasedNextTextField), for: .editingChanged)
        codeTextField3.addTarget(self, action: #selector(switchBasedNextTextField), for: .editingChanged)
        codeTextField4.addTarget(self, action: #selector(switchBasedNextTextField), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func switchBasedNextTextField(_ textField: UITextField) {
        if textField.text?.count == 1 {
            switch textField {
            case self.codeTextField1:
                self.codeTextField2.becomeFirstResponder()
            case self.codeTextField2:
                self.codeTextField3.becomeFirstResponder()
            case self.codeTextField3:
                self.codeTextField4.becomeFirstResponder()
            default:
                self.codeTextField4.resignFirstResponder()
            }
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
    }
}
