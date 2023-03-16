//
//  Endpoint.swift
//  Mobven-Project
//
//  Created by Zehra on 16.03.2023.
//

import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var method: RequestMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: String]? { get }
    var header: [String: String]? { get }
}

extension Endpoint {
    public var scheme: String {
        return "https"
    }
    
    public var host: String {
        return "momentumv2.mobven.com:7076"
    }
}
