//
//  RequestError.swift
//  Mobven-Project
//
//  Created by Zehra on 16.03.2023.
//

import Foundation

public enum RequestError: Error {
    case unauthorized
    case unknown
    case invalidURL
    case noResponse
    case decode
    
    var customMessage: String {
        switch self {
        case .unauthorized:
            return "Session expired"
        case .decode:
            return "Decode error"
        default:
            return "Unknown error"
        }
    }
}

