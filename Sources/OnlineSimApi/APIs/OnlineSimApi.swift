//
//  File.swift
//  
//
//  Created by Alexey on 30.03.2023.
//

import Foundation

public protocol IOnlineSimApi {
    /// Retrieves the account balance.
    /// Returns: `BalanceResponse` containing account balance information.
    func getBalance() async throws -> BalanceResponse
    
    /// Retrieves the numbers statistics.
    /// - Parameter country: Filter statistics by `GetStatsCountry` (optional).
    /// Returns: `CountryStats` containing statistics for the selected country or all countries if no country is provided.
    func getNumbersStats(country: GetStatsCountry?) async throws -> CountryStats
    
    /// Requests a new number for the specified service.
    /// - Parameter request: `GetOnlineSimNumberRequest` containing the service and other optional parameters.
    /// Returns: `GetOnlineSimNumberResponse` containing the response, number, and operation identifier.
    func getNumber(with request: GetOnlineSimNumberRequest) async throws -> GetOnlineSimNumberResponse
    
    /// Retrieves the state of requested numbers.
    /// - Parameter request: `GetOnlineSimStateRequest` containing optional parameters to filter the results.
    /// Returns: An array of GetOnlineSimStateResponse containing the state of requested numbers.
    func getState(with request: GetOnlineSimStateRequest) async throws -> [GetOnlineSimStateResponse]
    
    /// Sends a request for a different code in case if multiple SMSs have been received at the same number with different codes.
    /// - Parameter request: `SetOperationReviseRequest` containing the operation identifier.
    /// Returns: `SetOperationReviseResponse` containing the operation ID and response status.
    func setOperationRevise(with request: SetOperationReviseRequest) async throws -> SetOperationReviseResponse
    
    /// Sends a notification of successful reception of the code and completes the operation.
    /// - Parameter request: `SetOperationOkRequest` containing the operation identifier and an optional ban parameter.
    /// Returns: `SetOperationOkResponse` containing the operation ID and response status.
    func setOperationOk(with request: SetOperationOkRequest) async throws -> SetOperationOkResponse
    
    /// Waits for an SMS code to be received for a specific operation and returns it.
    /// - Parameter operationId: The operation identifier for which the SMS code is expected.
    /// - Parameter attempts: The number of attempts to try receiving the SMS code before giving up.
    /// - Parameter setStatusAfterCompletion: A flag that indicates whether to update the operation status after receiving the SMS code.
    /// Returns: The received SMS code as a `String`.
    func waitForCode(operationId: Int, attempts: Int, setStatusAfterCompletion: Bool) async throws -> String
}


public final class OnlineSimApi: HTTPClient, IOnlineSimApi {
    
    let urlSession: URLSession
    
    public init(apiKey: String,
                baseScheme: String = Constants.baseScheme,
                baseHost: String = Constants.baseHost,
                path: String = Constants.path,
                urlSession: URLSession = .shared) {
        Constants.apiKey = apiKey
        Constants.baseScheme = baseScheme
        Constants.baseHost = baseHost
        Constants.path = path
        self.urlSession = urlSession
    }
    
    public func getBalance() async throws -> BalanceResponse {
        let endpoint = OnlineSimEndpoint.getBalance
        let result = await sendRequest(session: urlSession, endpoint: endpoint, responseModel: BalanceResponse.self)
        let response = try result.get()
        return response
    }
    
    public func getNumbersStats(country: GetStatsCountry?) async throws -> CountryStats {
        let endpoint = OnlineSimEndpoint.getNumbersStats(country)
        let result = await sendRequest(session: urlSession, endpoint: endpoint, responseModel: CountryStats.self)
        let response = try result.get()
        return response
    }
    
    public func getNumber(with request: GetOnlineSimNumberRequest) async throws -> GetOnlineSimNumberResponse {
        let endpoint = OnlineSimEndpoint.getNumber(request)
        let result = await sendRequest(session: urlSession, endpoint: endpoint, responseModel: GetOnlineSimNumberResponse.self)
        let response = try result.get()
        return response
    }
    
    public func getState(with request: GetOnlineSimStateRequest) async throws -> [GetOnlineSimStateResponse] {
        let endpoint = OnlineSimEndpoint.getState(request)
        let result = await sendRequest(session: urlSession, endpoint: endpoint, responseModel: [GetOnlineSimStateResponse].self)
        let response = try result.get()
        return response
    }
    
    public func setOperationRevise(with request: SetOperationReviseRequest) async throws -> SetOperationReviseResponse {
        let endpoint = OnlineSimEndpoint.setOperationRevise(request)
        let result = await sendRequest(session: urlSession, endpoint: endpoint, responseModel: SetOperationReviseResponse.self)
        let response = try result.get()
        return response
    }
    
    @discardableResult
    public func setOperationOk(with request: SetOperationOkRequest) async throws -> SetOperationOkResponse {
        let endpoint = OnlineSimEndpoint.setOperationOk(request)
        let result = await sendRequest(session: urlSession, endpoint: endpoint, responseModel: SetOperationOkResponse.self)
        let response = try result.get()
        return response
    }
    
    public func waitForCode(operationId: Int, attempts: Int = 40, setStatusAfterCompletion: Bool = false) async throws -> String {
        if attempts <= 0 { throw OnlineSimError.noCodeReceived }
        
        let stateResponses: [GetOnlineSimStateResponse] = try await getState(with: GetOnlineSimStateRequest())
        let state = stateResponses.first { $0.operationId == operationId }
        
        guard let state else { throw OnlineSimError.operationNotFound }
        if let code = state.code {
            if setStatusAfterCompletion {
                try await setOperationOk(with: SetOperationOkRequest(tzid: operationId))
            }
            return code
        }
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        return try await waitForCode(operationId: operationId, attempts: attempts - 1, setStatusAfterCompletion: setStatusAfterCompletion)
        
    }
    
}
