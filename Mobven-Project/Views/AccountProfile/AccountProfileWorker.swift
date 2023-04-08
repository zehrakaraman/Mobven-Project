//
//  AccountProfileWorker.swift
//  Mobven-Project
//
//  Created by Zehra on 31.03.2023.
//

import Foundation

protocol AccountProfileWorkingLogic: AnyObject {
    func getProfile(completion: @escaping ((Result<[Account], CoreDataError>) -> Void))
    func updateProfile(completion: @escaping ((Result<Void, CoreDataError>) -> Void))
    func createProfile(gender: String, dateOfBirth: Date, completion: @escaping ((Result<Account, CoreDataError>) -> Void))
}

final class AccountProfileWorker: AccountProfileWorkingLogic {
    private let coreDataManager = CoreDataManager.shared
    
    func getProfile(completion: @escaping ((Result<[Account], CoreDataError>) -> Void)) {
        coreDataManager.read(type: Account.self, completion: completion)
    }
    
    func updateProfile(completion: @escaping ((Result<Void, CoreDataError>) -> Void)) {
        coreDataManager.update(completion: completion)
    }
    
    func createProfile(gender: String, dateOfBirth: Date, completion: @escaping ((Result<Account, CoreDataError>) -> Void)) {
        coreDataManager.create(type: Account.self, completion: { [weak self] result in
            switch result {
            case .success(let profile):
                profile.gender = gender
                profile.dateOfBirth = dateOfBirth
                self?.coreDataManager.update(completion: { result in
                    switch result {
                    case .success:
                        completion(.success(profile))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
