//
//  File.swift
//  
//
//  Created by Alexey on 30.03.2023.
//

import Foundation

public struct CountryStats: Codable {
    
    public let name: String
    public let position: Int
    public let code: Int
    public let other: Bool
    public let isNew: Bool
    public let isEnabled: Bool
    public let services: [String: ServiceInfo]

    public struct ServiceInfo: Codable {
        public let count: Int
        public let popular: Bool
        public let code: Int
        public let price: Double
        public let id: Int
        public let service: String
        public let slug: String
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case position
        case code
        case other
        case isNew = "new"
        case isEnabled = "enabled"
        case services
    }
    
    public init(name: String, position: Int, code: Int, other: Bool, isNew: Bool, isEnabled: Bool, services: [String : CountryStats.ServiceInfo]) {
        self.name = name
        self.position = position
        self.code = code
        self.other = other
        self.isNew = isNew
        self.isEnabled = isEnabled
        self.services = services
    }
}
