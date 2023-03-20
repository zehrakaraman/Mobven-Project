//
//  LoginModels.swift
//  Mobven-Project
//
//  Created by Zehra on 20.03.2023.
//

import Foundation

// swiftlint:disable nesting
enum Login {
    
    enum Case {
        
        struct Request {
            
        }
        
        struct Response {
            let loginResponse: LoginResponse
        }
        
        struct ViewModel {
            let nameSurname: String
            let email: String
            let profilePhoto: String
            let accessToken: String
        }
    }
}
// swiftlint:enable nesting
