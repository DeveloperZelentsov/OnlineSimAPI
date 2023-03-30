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
}
