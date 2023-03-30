//
//  File.swift
//  
//
//  Created by Alexey on 30.03.2023.
//

import Foundation

public struct GetOnlineSimNumberResponse: Codable {
    public let response: Int
    public let operationId: Int

    public init(response: Int, operationId: Int) {
        self.response = response
        self.operationId = operationId
    }

    enum CodingKeys: String, CodingKey {
        case response
        case operationId = "tzid"
    }
}
