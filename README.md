# OnlineSimApi Swift Library #

A Swift library that provides an easy-to-use interface for [OnlineSim](https://onlinesim.io/?ref=2541522) API services.

## Features ##

* Asynchronous API calls using Swift's async/await syntax
* Simple and straightforward usage
* Comprehensive protocol with all major OnlineSim API methods
* Unit tested for reliability

## Requirements ##

* iOS 15.0+
* Swift 5.6+

## Installation ##

Add the library to your project using Swift Package Manager:

1. Open your project in Xcode.
2. Go to File > Swift Packages > Add Package Dependency.
3. Enter the repository URL `https://github.com/DeveloperZelentsov/OnlineSimApi` for the OnlineSimApi library and click Next.
4. Choose the latest available version and click Next.
5. Select the target where you want to use SmsActivateAPI and click Finish.

## Usage ##

### Initialization ###

First, import the **_OnlineSimApi_** library in your Swift file:

```swift
import OnlineSimApi
```

To start using the library, create an instance of **_OnlineSimApi_** with your API key:

```swift
let onlineSimApi = OnlineSimApi(apiKey: "your_api_key_here")
```

### Get account balance ###

To get the account balance, call the `getBalance()` function:

```swift
do {
    let balanceResponse = try await onlineSimApi.getBalance()
    print("Account balance: \(balanceResponse.balance)")
} catch {
    print("Error: \(error)")
}
```

### Request a phone number ###

To request a phone number, create a GetOnlineSimNumberRequest object and call the `getNumber(with request: GetOnlineSimNumberRequest)` function:

```swift
do {
    let request = GetOnlineSimNumberRequest(service: "your_service", country: 7)
    let response = try await onlineSimApi.getNumber(with: request)
    print("Operation ID: \(response.tzid), Phone Number: \(response.number)")
} catch {
    print("Error: \(error)")
}
```

### Wait for code ###

The `waitForCode(operationId: Int, attempts: Int = 40, setStatusAfterCompletion: Bool = false)` function is an asynchronous method designed to simplify the process of waiting for an SMS code to be received for a specific operation. This function periodically checks the operation status until a code is received or a specified number of attempts has been reached.

```swift
do {
    let operationId = 12345
    let code = try await onlineSimApi.waitForCode(operationId: operationId)
    print("Received code: \(code)")
} catch {
    print("Error: \(error)")
}
```

### Other functions ###

You can use other functions provided by the **_IOnlineSimApi_** protocol, such as `getNumbersStats`, `getState`, `setOperationRevise`, and `setOperationOk`, following the same pattern demonstrated in the examples above. Make sure to check the function parameters and expected return types in the protocol definition to understand how to use them properly.

For more information on the available methods and their parameters, refer to the **_IOnlineSimApi_** protocol and the library's source code.

## License ##

This project is released under the MIT License.
