//
//  File.swift
//  
//
//  Created by Alexey on 30.03.2023.
//

import Foundation

public enum OnlineSimEndpoint {
    case getBalance
    case getNumbersStats(GetStatsCountry?)
    case getNumber(GetOnlineSimNumberRequest)
    case getState(GetOnlineSimStateRequest)
}

extension OnlineSimEndpoint: CustomEndpoint {
    
    public var url: URL? {
        var urlComponents: URLComponents = .default
        urlComponents.queryItems = queryItems
        urlComponents.path = path
        return urlComponents.url
    }
    
    public var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = [.init(name: "apikey", value: Constants.apiKey),
                                     .init(name: "lang", value: "en")]
        switch self {
        case .getBalance:
            break
        case .getNumbersStats(let country):
            var value: String = "7"
            if let country {
                value = country == .allCountries ? "all" : country.rawValue.description
            }
            items.append(.init(name: "country", value: value))
        case .getNumber(let request):
            items.append(.init(name: "service", value: request.service))
            if let region = request.region {
                items.append(.init(name: "region", value: region.description))
            }
            if let country = request.country {
                items.append(.init(name: "country", value: country.description))
            }
            if let reject = request.reject {
                let rejectString = reject.map { String($0) }.joined(separator: ",")
                items.append(.init(name: "reject", value: rejectString))
            }
            if let ext = request.ext {
                items.append(.init(name: "extension", value: ext.description))
            }
            if let developerId = request.developerId {
                items.append(.init(name: "dev_id", value: developerId.description))
            }
            if let number = request.number {
                items.append(.init(name: "number", value: number.description))
            }
        case .getState(let request):
            if let tzid = request.operationId {
                items.append(.init(name: "tzid", value: String(tzid)))
            }
            if let messageToCode = request.extractCodeOnly {
                items.append(.init(name: "message_to_code", value: String(messageToCode)))
            }
            if let form = request.receptionType {
                items.append(.init(name: "form", value: String(form)))
            }
            if let orderby = request.sortOrder {
                items.append(.init(name: "orderby", value: orderby))
            }
            if let msgList = request.messageType {
                items.append(.init(name: "msg_list", value: String(msgList)))
            }
            if let clean = request.excludeCircularMessages {
                items.append(.init(name: "clean", value: String(clean)))
            }
        }
        return items
    }
    
    public var path: String {
        var fullPath = Constants.path
        switch self {
        case .getBalance:
            fullPath += "/getBalance.php"
        case .getNumbersStats:
            fullPath += "/getNumbersStats.php"
        case .getNumber:
            fullPath += "/getNum.php"
        case .getState:
            fullPath += "/getState.php"
        }
        return fullPath
    }
    
    public var method: HTTPRequestMethods {
        return .get
    }
    
    public var header: [String : String]? {
        return nil
    }
    
    public var body: BodyInfo? {
        return nil
    }
    
}
