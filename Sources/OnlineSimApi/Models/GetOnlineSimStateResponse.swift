//
//  File.swift
//  
//
//  Created by Alexey on 30.03.2023.
//

import Foundation

public struct GetOnlineSimStateResponse: Codable {
    
    public let countryCode: Int
    public let cost: Double
    public let code: String?
    public let service: String
    public let phoneNumber: String
    public let status: String
    public let operationId: Int
    public let timeRemaining: Int
    public let form: String

    enum CodingKeys: String, CodingKey {
        case countryCode = "country"
        case cost = "sum"
        case code = "msg"
        case service
        case phoneNumber = "number"
        case status = "response"
        case operationId = "tzid"
        case timeRemaining = "time"
        case form
    }
    
    public init(countryCode: Int, cost: Double, service: String, phoneNumber: String, status: String, operationId: Int, timeRemaining: Int, form: String, code: String) {
        self.countryCode = countryCode
        self.cost = cost
        self.service = service
        self.phoneNumber = phoneNumber
        self.status = status
        self.operationId = operationId
        self.timeRemaining = timeRemaining
        self.form = form
        self.code = code
    }
}
