//
//  File.swift
//  
//
//  Created by Alexey on 30.03.2023.
//

import Foundation

public struct BalanceResponse: Codable {
    public let response: String
    public let balance: String
    public let zbalance: Int
}
