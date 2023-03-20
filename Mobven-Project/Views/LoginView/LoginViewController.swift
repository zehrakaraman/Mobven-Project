//
//  LoginViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 20.03.2023.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayAuthorizedPerson(viewModel: Login.Case.ViewModel)
}

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    var viewModel: Login.Case.ViewModel?
    
    var constraint: CGFloat = 0
    
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
        
        configureTextField([emailTextField, passwordTextField])
        configureLabel()
        
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
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func configureLabel() {
        if let fullText = termsLabel.text {
            self.termsLabel.changeColorText(fullText: fullText, changeText: "Terms and Condition")
        }
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.termsLabel.text else { return }
        let termsAndConditionRange = (text as NSString).range(of: "Terms and Condition")
        if gesture.didTapAttributedTextInLabel(label: termsLabel, inRange: termsAndConditionRange) {
            print("Tapped terms and condition")
        }
    }
        
    @IBAction func tappedNextButton(_ sender: UIButton) {
//        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        let email = "ytp2023@mobven.com"
        let password = "YTP2023"
        interactor?.login(email: email, password: password)
    }
}

extension LoginViewController: LoginDisplayLogic {
    func displayAuthorizedPerson(viewModel: Login.Case.ViewModel) {
        self.viewModel = viewModel
        
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel else { return }
            print("Login is succesful for \(viewModel.nameSurname)")
            self.router?.routeToHome()
        }
    }
}

// MARK: Keyboard Configuration

extension LoginViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if termsLabel.frame.origin.y != keyboardSize.height {
            constraint = termsLabel.frame.origin.y - keyboardSize.origin.y
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.topConstraint.constant -= (self.constraint + self.termsLabel.frame.height + 10)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if constraint != 0 {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.topConstraint.constant += (self.constraint + self.termsLabel.frame.height + 10)
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

extension LoginViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.resignFirstResponder()
            tappedNextButton(nextButton)
        }
    }
}
