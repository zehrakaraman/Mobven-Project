//
//  VerificationInteractor.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import Foundation

protocol VerificationBusinessLogic: AnyObject {
    
}

protocol VerificationDataStore: AnyObject {
    
}

final class VerificationInteractor: VerificationBusinessLogic, VerificationDataStore {
    
    var presenter: VerificationPresentationLogic?
    var worker: VerificationWorkingLogic = VerificationWorker()
    
}
