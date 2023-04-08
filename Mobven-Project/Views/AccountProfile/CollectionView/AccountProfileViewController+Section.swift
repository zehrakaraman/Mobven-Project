//
//  AccountProfileViewController+Section.swift
//  Mobven-Project
//
//  Created by Zehra on 5.04.2023.
//

import UIKit

extension AccountProfileViewController {
    enum Section: Int, Hashable {
        case view
        case name
        case gender
        case birthOfDate
        
        var title: String {
            switch self {
            case .view: return ""
            case .name:
                return NSLocalizedString("Name", comment: "Name section name")
            case .gender:
                return NSLocalizedString("Gender", comment: "Gender section name")
            case .birthOfDate:
                return NSLocalizedString("Date of birth", comment: "Date section name")
            }
        }
    }
}
