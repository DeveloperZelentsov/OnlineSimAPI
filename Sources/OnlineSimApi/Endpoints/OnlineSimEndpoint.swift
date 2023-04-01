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
    case setOperationRevise(SetOperationReviseRequest)
    case setOperationOk(SetOperationOkRequest)
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
                let rejectString = reject.map { $0.description }.joined(separator: ",")
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
                items.append(.init(name: "tzid", value: tzid.description))
            }
            items.append(.init(name: "message_to_code", value: request.extractCodeOnly.description))
            
            if let form = request.receptionType {
                items.append(.init(name: "form", value: form.description))
            }
            if let orderby = request.sortOrder {
                items.append(.init(name: "orderby", value: orderby))
            }
            if let msgList = request.messageType {
                items.append(.init(name: "msg_list", value: msgList.description))
            }
            if let clean = request.excludeCircularMessages {
                items.append(.init(name: "clean", value: clean.description))
            }
        case .setOperationRevise(let request):
            items.append(.init(name: "tzid", value: request.operationId.description))
        case .setOperationOk(let request):
            items.append(.init(name: "tzid", value: "\(request.tzid)"))
            if let ban = request.ban {
                items.append(.init(name: "ban", value: "\(ban)"))
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
        case .setOperationRevise:
            fullPath += "/setOperationRevise.php"
        case .setOperationOk:
            fullPath += "/setOperationOk.php"
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
