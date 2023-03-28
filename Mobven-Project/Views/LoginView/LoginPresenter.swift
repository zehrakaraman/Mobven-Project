//
//  LoginPresenter.swift
//  Mobven-Project
//
//  Created by Zehra on 20.03.2023.
//

import Foundation

protocol LoginPresentationLogic: AnyObject {
    func presentLogin(response: Login.Case.Response)
}

final class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
    
    func presentLogin(response: Login.Case.Response) {
        let authorized = response.loginResponse.body
        let authorizedUser = Login.Case.ViewModel(
            nameSurname: authorized.fullName,
            email: authorized.email,
            profilePhoto: authorized.profilePhoto,
            accessToken: authorized.accessToken)
        
        viewController?.displayAuthorizedPerson(viewModel: authorizedUser)
    }
    
}
