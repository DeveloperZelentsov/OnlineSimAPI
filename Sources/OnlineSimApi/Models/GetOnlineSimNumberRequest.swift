//
//  File.swift
//  
//
//  Created by Alexey on 30.03.2023.
//

import Foundation

public struct GetOnlineSimNumberRequest: Codable {
    public let service: String
    public let region: Int?
    public let country: Int?
    public let reject: [Int]?
    public let ext: Int?
    public let developerId: Int?
    public let number: Bool?

    public init(service: String, region: Int? = nil, country: Int? = nil, reject: [Int]? = nil, ext: Int? = nil, developerId: Int? = nil, number: Bool? = nil) {
        self.service = service
        self.region = region
        self.country = country
        self.reject = reject
        self.ext = ext
        self.developerId = developerId
        self.number = number
    }

    enum CodingKeys: String, CodingKey {
        case service
        case region
        case country
        case reject
        case ext = "extension"
        case developerId = "dev_id"
        case number
    }
}
