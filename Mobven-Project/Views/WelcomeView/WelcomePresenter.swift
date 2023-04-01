//
//  WelcomePresenter.swift
//  Mobven-Project
//
//  Created by Zehra on 1.04.2023.
//

import Foundation

protocol WelcomePresentationLogic: AnyObject {
    
}

final class WelcomePresenter: WelcomePresentationLogic {
    
    weak var viewController: WelcomeDisplayLogic?
    
}
