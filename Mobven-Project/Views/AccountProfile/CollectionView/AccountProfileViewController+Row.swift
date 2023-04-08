//
//  AccountProfileViewController+Row.swift
//  Mobven-Project
//
//  Created by Zehra on 5.04.2023.
//

import UIKit

extension AccountProfileViewController {
    enum Row: Hashable {
        case header(String)
        case viewName
        case viewGender
        case viewDate
        case editText(String?)
        case editGender(String)
        case editDate(Date)
        
        var font: UIFont {
            switch self {
            case .viewName: return UIFont(name: "Montserrat-Bold", size: 22)!
            default: return UIFont(name: "Montserrat-SemiBold", size: 12) ?? .systemFont(ofSize: 12)
            }
        }
        
        var title: String? {
            switch self {
            case .viewGender: return "Gender"
            case .viewDate: return "Birth of date"
            default: return nil
            }
        }
    }
    
}
