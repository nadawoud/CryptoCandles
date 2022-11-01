//
//  NetworkServiceMock.swift
//  CryptoCandlesTests
//
//  Created by Nada Yehia Dawoud on 01/11/2022.
//

import XCTest
@testable import CryptoCandles

class NetworkServiceMock: CryptoCandlesService {
    
    var isFetchRequestCalled = false
    var candlesticks = Candlesticks()
    var completionClosure: ((Result<Candlesticks, NetworkError>) -> Void)!
    
    func fetchCandlesticks(forCurrency currency: CryptoCandles.CryptoCurrency, completion: @escaping (Result<CryptoCandles.Candlesticks, CryptoCandles.NetworkError>) -> Void) {
        isFetchRequestCalled = true
        completionClosure = completion
    }
}
