//
//  File.swift
//  
//
//  Created by Alexey on 01.04.2023.
//

import Foundation

public struct SetOperationReviseResponse: Codable {
    let response: Int
    let operationId: Int
    
    private enum CodingKeys: String, CodingKey {
        case response
        case operationId = "tzid"
    }
}
