//
//  VerificationViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import UIKit

protocol VerificationDisplayLogic: AnyObject {
    
}

final class VerificationViewController: UIViewController {
    static let identifier = "VerificationViewController"
    
    @IBOutlet weak var textFields: UIStackView!
    @IBOutlet weak var codeTextField1: UITextField!
    @IBOutlet weak var codeTextField2: UITextField!
    @IBOutlet weak var codeTextField3: UITextField!
    @IBOutlet weak var codeTextField4: UITextField!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var constraint: CGFloat = 0
    
    var interactor: VerificationBusinessLogic?
    var router: (VerificationRoutingLogic & VerificationDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backButtonTitle = ""
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        router?.routeToLogin()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = VerificationInteractor()
        let presenter = VerificationPresenter()
        let router = VerificationRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension VerificationViewController: VerificationDisplayLogic {
    
}

// MARK: Keyboard Configuration

extension VerificationViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if textFields.frame.origin.y > keyboardSize.origin.y {
            constraint = textFields.frame.origin.y - keyboardSize.origin.y
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.topConstraint.constant -= (self.constraint + self.textFields.frame.height + 10)
                self.view.layoutIfNeeded()
            })
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if constraint != 0 {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.topConstraint.constant += (self.constraint + self.textFields.frame.height + 10)
                self.constraint = 0
                self.view.layoutIfNeeded()
                self.dismissKeyboard()
            })
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: TextField Switch

extension VerificationViewController {
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
}
