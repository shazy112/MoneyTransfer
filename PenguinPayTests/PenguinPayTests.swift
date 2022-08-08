//
//  PenguinPayTests.swift
//  PenguinPayTests
//
//  Created by Sheearz Ahmed on 6/20/22.
//

import XCTest

@testable import PenguinPay

class PenguinPayTests: XCTestCase {
    
    var mock: SendMoneyMock = SendMoneyMock()
    var viewModel: SendMoneyViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = SendMoneyViewModel(repository: mock)
        viewModel.vmCallbacks = { state in
            switch state {
            case .currenciesFetched:
                XCTAssertEqual(self.mock.currenciesFetched, true)
            default:
                break
            }
        }
    }
    
    func testCurrenciesFetched() {
        Task {
            await viewModel.getCurrencies()
        }
    }
    
    func testCurrencyCalculation() {
        let amount = viewModel.repository?.doCalculationForMock(inputAmount: "101", currencyAbbreviation: "KES") ?? ""
        XCTAssertEqual(amount, "1001001001")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
