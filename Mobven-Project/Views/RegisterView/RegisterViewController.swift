//
//  RegisterViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import UIKit

protocol RegisterDisplayLogic: AnyObject {
    
}

final class RegisterViewController: UIViewController {
    static let identifier = "RegisterViewController"
    
    @IBOutlet weak var accountImageButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    
    var constraint: CGFloat = 0
    
    var interactor: RegisterBusinessLogic?
    var router: (RegisterRoutingLogic & RegisterDataPassing)?
    
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
        
        configureTextField([nameTextField])
    
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
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        router?.routeToVerification()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension RegisterViewController: RegisterDisplayLogic {
    
}

// MARK: Keyboard Configuration

extension RegisterViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if nameTextField.frame.origin.y >= keyboardSize.origin.y {
            constraint = nameTextField.frame.origin.y - keyboardSize.origin.y
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.topConstraint.constant -= (self.constraint + self.nameTextField.frame.height + 10)
                self.view.layoutIfNeeded()
            })
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if constraint != 0 {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.topConstraint.constant += (self.constraint + self.nameTextField.frame.height + 10)
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

extension RegisterViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        nextButtonTapped(nextButton)
        return false
    }
}
