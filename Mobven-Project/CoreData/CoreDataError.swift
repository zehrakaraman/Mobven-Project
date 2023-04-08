//
//  CoreDataError.swift
//  Mobven-Project
//
//  Created by Zehra on 4.04.2023.
//

import Foundation

public enum CoreDataError: Error {
    case fetch
    case read
    case create
    case update
    case save
    case unknown
    
    var customMessage: String {
        switch self {
        case .create:
            return "Create entity error"
        case .fetch:
            return "Fetch entity error"
        case .read:
            return "Read entity error"
        case .save:
            return "Save entity error"
        case .update:
            return "Update entity error"
        default:
            return "Unknown error"
        }
    }
}
