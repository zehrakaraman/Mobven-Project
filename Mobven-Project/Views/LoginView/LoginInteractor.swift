//
//  LoginInteractor.swift
//  Mobven-Project
//
//  Created by Zehra on 20.03.2023.
//

import Foundation

protocol LoginBusinessLogic: AnyObject {
    func login(email: String, password: String)
}

protocol LoginDataStore: AnyObject {
    var loginResponse: LoginResponse? { get set }
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    var loginResponse: LoginResponse?
    
    func login(email: String, password: String) {
        worker.getLogin(email: email, password: password) { result in
            switch result {
            case .success(let response):
                self.loginResponse = response
                guard let loginResponse = self.loginResponse else { return }
                let accessToken = loginResponse.body.accessToken
                
                KeyChainManager.shared.saveData(Data(accessToken.utf8), service: KeyChainConstants.accessTokenService, account: KeyChainConstants.account)
                
                self.presenter?.presentLogin(response: Login.Case.Response(loginResponse: loginResponse))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
