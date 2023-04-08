//
//  AccountProfileViewController+CellConfiguration.swift
//  Mobven-Project
//
//  Created by Zehra on 5.04.2023.
//

import UIKit

extension AccountProfileViewController {
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = row.font
        contentConfiguration.textProperties.color = UIColor(named: "Blue - Dark")!
        contentConfiguration.secondaryText = row.title
        contentConfiguration.secondaryTextProperties.font = UIFont(name: "Montserrat-Regular", size: 10)!
        contentConfiguration.secondaryTextProperties.color = UIColor(named: "Blue - Light")!
        return contentConfiguration
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        contentConfiguration.textProperties.font = UIFont(name: "Montserrat-Regular", size: 10)!
        contentConfiguration.textProperties.color = UIColor(named: "Blue - Dark")!
        return contentConfiguration
    }
    
    func nameConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
        var contentConfiguration = cell.textFieldConfiguration()
        contentConfiguration.text = title
        contentConfiguration.onChange = {[weak self] name in
            self?.router?.dataStore?.account?.fullName = name
        }
        return contentConfiguration
    }
    
    func genderConfiguration(for cell: UICollectionViewListCell, with gender: String) -> GenderContentView.Configuration {
        var contentConfiguration = cell.genderViewConfiguration()
        contentConfiguration.text = gender
        contentConfiguration.onChange = { [weak self] gender in
            self?.interactor?.saveGender(gender: gender)
        }
        return contentConfiguration
    }
    
    func dateConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickerContentView.Configuration {
        var contentConfiguration = cell.datePickerConfiguration()
        contentConfiguration.date = date
        contentConfiguration.onChange = { [weak self] date in
            self?.interactor?.saveDate(date: date)
        }
        return contentConfiguration
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .viewName: return router?.dataStore?.account?.fullName
        case .viewGender: return router?.dataStore?.profileData?.gender
        case .viewDate:
            guard let date = router?.dataStore?.profileData?.dateOfBirth else { return nil }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        default: return nil
        }
    }
    
}
