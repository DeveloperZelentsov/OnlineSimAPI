//
//  File.swift
//  
//
//  Created by Alexey on 01.04.2023.
//

import Foundation

public struct SetOperationOkRequest: Codable {
    
    let tzid: Int
    let ban: Int?
    
    public init(tzid: Int, ban: Int? = nil) {
        self.tzid = tzid
        self.ban = ban
    }
}

