//
//  AccountProfileInteractor.swift
//  Mobven-Project
//
//  Created by Zehra on 31.03.2023.
//

import Foundation

protocol AccountProfileBusinessLogic: AnyObject {
    func loadProfile()
    func saveGender(gender: String)
    func saveDate(date: Date)
}

protocol AccountProfileDataStore: AnyObject {
    var account: Authorized? { get set }
    var profileData: Account? { get set }
}

final class AccountProfileInteractor: AccountProfileBusinessLogic, AccountProfileDataStore {
    var presenter: AccountProfilePresentationLogic?
    var worker: AccountProfileWorkingLogic = AccountProfileWorker()
    var account: Authorized?
    var profileData: Account?
    
    func loadProfile() {
        worker.getProfile() { [weak self] result in
            switch result {
            case .success(let profileData):
                guard let profile = profileData.last else { return }
                self?.profileData = profile
                self?.presenter?.presentProfile(model: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveGender(gender: String) {
        if let currentProfileData = profileData {
            currentProfileData.gender = gender
            worker.updateProfile { [weak self] result in
                switch result {
                case .success:
                    self?.presenter?.presentProfile(model: currentProfileData)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            worker.createProfile(gender: gender, dateOfBirth: Date.now) { [weak self] result in
                switch result {
                case .success(let profileData):
                    self?.profileData = profileData
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func saveDate(date: Date) {
        if let currentProfileData = profileData {
            currentProfileData.dateOfBirth = date
            worker.updateProfile { [weak self] result in
                switch result {
                case .success:
                    self?.presenter?.presentProfile(model: currentProfileData)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            worker.createProfile(gender: "Gender", dateOfBirth: date) { [weak self] result in
                switch result {
                case .success(let profileData):
                    self?.profileData = profileData
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
//    func saveProfile(dateOfBirth: Date, gender: String) {
//        if let currentProfileData = profileData {
//            currentProfileData.dateOfBirth = dateOfBirth
//            currentProfileData.gender = gender
//            worker.updateProfile { [weak self] result in
//                switch result {
//                case .success:
//                    self?.presenter?.presentProfile(model: currentProfileData)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        } else {
//            worker.createProfile(dateOfBirth: dateOfBirth) { [weak self] result in
//                switch result {
//                case .success(let profileData):
//                    self?.profileData = profileData
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
}
