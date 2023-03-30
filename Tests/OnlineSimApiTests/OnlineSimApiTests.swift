
import XCTest
@testable import OnlineSimApi

final class OnlineSimApiTests: XCTestCase {
    private var onlineSimApi: OnlineSimApi!
    private var expectation: XCTestExpectation!
    private let apiKey = ""
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        onlineSimApi = OnlineSimApi(apiKey: apiKey, urlSession: urlSession)
        expectation = expectation(description: "Expectation")
    }
    
    override func tearDown() {
        onlineSimApi = nil
        super.tearDown()
    }
    
    func testGetBalance() async throws {
        // Prepare response
        let mockResponse = """
            {
                "response": "1",
                "balance": "100",
                "zbalance": 0
            }
            """
        let responseData = mockResponse.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, responseData)
        }
        
        // Call API
        do {
            let balanceResponse = try await onlineSimApi.getBalance()
            XCTAssertEqual(balanceResponse.balance, "100", "Expected balance to be 100")
            expectation.fulfill()
        } catch {
            XCTFail("Error occurred: \(error)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetNumbersStats() async throws {
        // Prepare response
        let mockResponse = """
            {
                "name": "russia",
                "position": 0,
                "code": 7,
                "other": false,
                "new": false,
                "enabled": true,
                "services": {
                    "service_vkcom": {
                        "count": 3150,
                        "popular": false,
                        "code": 7,
                        "price": 0.55000000000000004,
                        "id": 1,
                        "service": "ВКонтакте",
                        "slug": "vkcom"
                    },
                    "service_3223": {
                        "count": 8141,
                        "popular": false,
                        "code": 7,
                        "price": 0.27000000000000002,
                        "id": 2,
                        "service": "Facebook",
                        "slug": "3223"
                    },
                    "service_mailru": {
                        "count": 5060,
                        "popular": false,
                        "code": 7,
                        "price": 0.55000000000000004,
                        "id": 3,
                        "service": "Mail.ru",
                        "slug": "mailru"
                    }
                }
            }
            """
        let responseData = mockResponse.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, responseData)
        }
        
        // Call API
        do {
            let stats: CountryStats = try await onlineSimApi.getNumbersStats(country: .russia)
            XCTAssertEqual(stats.code, 7, "Expected country code in the response 7")
            XCTAssertEqual(stats.services.count, 3, "Expected services to be 3")
            expectation.fulfill()
        } catch {
            XCTFail("Error occurred: \(error)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetNumber() async throws {
        // Prepare response
        let mockResponse = """
            {
                "tzid": 89126678,
                "response": 1
            }
            """
        let responseData = mockResponse.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, responseData)
        }
        
        // Call API
        let request = GetOnlineSimNumberRequest(service: "vkcom")
        do {
            let response: GetOnlineSimNumberResponse = try await onlineSimApi.getNumber(with: request)
            XCTAssertEqual(response.operationId, 89126678, "Expected operationId in the response 89126678")
            expectation.fulfill()
        } catch {
            XCTFail("Error occurred: \(error)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetState() async throws {
        // Prepare response
        let mockResponse = """
            [
                {
                    "country": 7,
                    "sum": 0.12,
                    "service": "iherb",
                    "number": "+79210084813",
                    "response": "TZ_NUM_WAIT",
                    "tzid": 89145058,
                    "time": 847,
                    "form": "index"
                }
            ]
            """
        let responseData = mockResponse.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, responseData)
        }
        
        do {
            let response: [GetOnlineSimStateResponse] = try await onlineSimApi.getState(with: GetOnlineSimStateRequest())
            XCTAssertEqual(response.count, 1, "Expected state to be of length 1")
            XCTAssertEqual(response[0].cost, 0.12, "Expected response in the cost 0.12")
            XCTAssertEqual(response[0].phoneNumber, "+79210084813", "Expected number in the state +79210084813")
            expectation.fulfill()
        } catch {
            XCTFail("Error occurred: \(error)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
