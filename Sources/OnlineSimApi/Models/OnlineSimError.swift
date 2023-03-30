//
//  File.swift
//  
//
//  Created by Alexey on 30.03.2023.
//

import Foundation

struct OnlineSimException: Codable {
    let response: String
    
    var hasError: Bool {
        return OnlineSimError(rawValue: response) != nil
    }
    
    var description: String {
        return OnlineSimError(rawValue: response)?.errorDescription ?? "Unknown Error"
    }
}


public enum OnlineSimError: String, LocalizedError, CaseIterable {
    case accountBlocked = "ACCOUNT_BLOCKED"
    case wrongKey = "ERROR_WRONG_KEY"
    case noKey = "ERROR_NO_KEY"
    case noService = "ERROR_NO_SERVICE"
    case requestNotFound = "REQUEST_NOT_FOUND"
    case apiAccessDisabled = "API_ACCESS_DISABLED"
    case apiAccessIp = "API_ACCESS_IP"
    case lowBalance = "WARNING_LOW_BALANCE"
    case exceededConcurrentOperations = "EXCEEDED_CONCURRENT_OPERATIONS"
    case noNumber = "NO_NUMBER"
    case timeIntervalError = "TIME_INTERVAL_ERROR"
    case intervalConcurrentRequestsError = "INTERVAL_CONCURRENT_REQUESTS_ERROR"
    case tryAgainLater = "TRY_AGAIN_LATER"
    case noForwardForDeffer = "NO_FORWARD_FOR_DEFFER"
    case noNumberForForward = "NO_NUMBER_FOR_FORWARD"
    case errorLengthNumberForForward = "ERROR_LENGTH_NUMBER_FOR_FORWARD"
    case duplicateOperation = "DUPLICATE_OPERATION"
    case warningNoNums = "WARNING_NO_NUMS"
    case tzInpool = "TZ_INPOOL"
    case tzNumWait = "TZ_NUM_WAIT"
    case tzNumAnswer = "TZ_NUM_ANSWER"
    case tzOverEmpty = "TZ_OVER_EMPTY"
    case tzOverOk = "TZ_OVER_OK"
    case errorNoTzid = "ERROR_NO_TZID"
    case errorNoOperations = "ERROR_NO_OPERATIONS"
    case accountIdentificationRequired = "ACCOUNT_IDENTIFICATION_REQUIRED"
    
    public init?(rawValue: String) {
        switch rawValue {
        case "ACCOUNT_BLOCKED": self = .accountBlocked
        case "ERROR_WRONG_KEY": self = .wrongKey
        case "ERROR_NO_KEY": self = .noKey
        case "ERROR_NO_SERVICE": self = .noService
        case "REQUEST_NOT_FOUND": self = .requestNotFound
        case "API_ACCESS_DISABLED": self = .apiAccessDisabled
        case "API_ACCESS_IP": self = .apiAccessIp
        case "WARNING_LOW_BALANCE": self = .lowBalance
        case "EXCEEDED_CONCURRENT_OPERATIONS": self = .exceededConcurrentOperations
        case "NO_NUMBER": self = .noNumber
        case "TIME_INTERVAL_ERROR": self = .timeIntervalError
        case "INTERVAL_CONCURRENT_REQUESTS_ERROR": self = .intervalConcurrentRequestsError
        case "TRY_AGAIN_LATER": self = .tryAgainLater
        case "NO_FORWARD_FOR_DEFFER": self = .noForwardForDeffer
        case "NO_NUMBER_FOR_FORWARD": self = .noNumberForForward
        case "ERROR_LENGTH_NUMBER_FOR_FORWARD": self = .errorLengthNumberForForward
        case "DUPLICATE_OPERATION": self = .duplicateOperation
        case "WARNING_NO_NUMS": self = .warningNoNums
        case "TZ_INPOOL": self = .tzInpool
        case "TZ_NUM_WAIT": self = .tzNumWait
        case "TZ_NUM_ANSWER": self = .tzNumAnswer
        case "TZ_OVER_EMPTY": self = .tzOverEmpty
        case "TZ_OVER_OK": self = .tzOverOk
        case "ERROR_NO_TZID": self = .errorNoTzid
        case "ERROR_NO_OPERATIONS": self = .errorNoOperations
        case "ACCOUNT_IDENTIFICATION_REQUIRED": self = .accountIdentificationRequired
        default: return nil
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .accountBlocked: return "Account is blocked."
        case .wrongKey: return "Invalid API key."
        case .noKey: return "No API key provided."
        case .noService: return "Service not specified."
        case .requestNotFound: return "API method not specified."
        case .apiAccessDisabled: return "API access is disabled."
        case .apiAccessIp: return "Access from this IP is disabled in the profile."
        case .lowBalance: return "Not enough funds to buy the service."
        case .exceededConcurrentOperations: return "Maximum quantity of numbers booked concurrently is exceeded for your account."
        case .noNumber: return "Temporarily no numbers available for the selected service."
        case .timeIntervalError: return "Delayed SMS reception is not possible at this interval of time."
        case .intervalConcurrentRequestsError: return "Maximum quantity of concurrent requests for number issue is exceeded, try again later."
        case .tryAgainLater: return "Temporarily unable to perform the request."
        case .noForwardForDeffer: return "Forwarding can be activated only for online reception."
        case .noNumberForForward: return "There are no numbers for forwarding."
        case .errorLengthNumberForForward: return "Wrong length of the number for forwarding."
        case .duplicateOperation: return "Adding operations with identical parameters"
        case .warningNoNums: return "No matching numbers."
        case .tzInpool: return "Waiting for a number to be dedicated to the operation."
        case .tzNumWait: return "Waiting for response."
        case .tzNumAnswer: return "Response has arrived."
        case .tzOverEmpty: return "Response did not arrive within the specified time."
        case .tzOverOk: return "Operation has been completed."
        case .errorNoTzid: return "Tzid is not specified."
        case .errorNoOperations: return "No operations."
        case .accountIdentificationRequired: return "You have to go through an identification process: to order a messenger - in any way, for forward - on the passport."
        }
    }
}
