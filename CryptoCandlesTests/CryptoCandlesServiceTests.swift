//
//  CryptoCandlesServiceTests.swift
//  CryptoCandlesTests
//
//  Created by Nada Yehia Dawoud on 31/10/2022.
//

import XCTest
@testable import CryptoCandles

final class CryptoCandlesServiceTests: XCTestCase {
    
    var sut: CandlestickChartInteractor?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CandlestickChartInteractor()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFetchingChartData() {
        let sut = self.sut!
        let expectation = XCTestExpectation(description: "Fetch candlesticks chart data.")
        
        sut.fetchCandlesticks(forCurrency: CryptoCurrency.btc) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let candlesticks):
                XCTAssert(candlesticks.count > 0, "Candlesticks list is empty.")
                expectation.fulfill()
            
            case .failure(let error):
                XCTFail("Fetching candlesticks list failed \(error).")
            }
            
            self.wait(for: [expectation], timeout: 3.0)
        }
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
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
