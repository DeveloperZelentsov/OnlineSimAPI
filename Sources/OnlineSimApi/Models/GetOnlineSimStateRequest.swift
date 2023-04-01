//
//  File.swift
//  
//
//  Created by Alexey on 30.03.2023.
//

import Foundation

public struct GetOnlineSimStateRequest: Codable {
    public let operationId: Int?
    public let extractCodeOnly: Int
    public let receptionType: Int?
    public let sortOrder: String?
    public let messageType: Int?
    public let excludeCircularMessages: Int?
    
    public init(
        operationId: Int? = nil,
        extractCodeOnly: Int = 1,
        receptionType: Int? = nil,
        sortOrder: String? = nil,
        messageType: Int? = nil,
        excludeCircularMessages: Int? = nil
    ) {
        self.operationId = operationId
        self.extractCodeOnly = extractCodeOnly
        self.receptionType = receptionType
        self.sortOrder = sortOrder
        self.messageType = messageType
        self.excludeCircularMessages = excludeCircularMessages
    }
    
    enum CodingKeys: String, CodingKey {
        case operationId = "tzid"
        case extractCodeOnly = "message_to_code"
        case receptionType = "form"
        case sortOrder = "orderby"
        case messageType = "msg_list"
        case excludeCircularMessages = "clean"
    }
}
