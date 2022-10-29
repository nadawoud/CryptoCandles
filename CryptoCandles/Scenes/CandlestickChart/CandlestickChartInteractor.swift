//
//  CandlestickChartInteractor.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 29/10/2022.
//

import Foundation

protocol CandlestickChartBusinessLogic {
    func fetchChartData(forCurrency currency: CryptoCurrency)
}

class CandlestickChartInteractor: CandlestickChartBusinessLogic {
    
    func fetchChartData(forCurrency currency: CryptoCurrency) {
        
        NetworkManager.request(endpoint: CryptoCandleEndpoint.getCandlestickChartData(currency: currency)) { (result: Result<Candlesticks, Error>) in
            
            switch result {
            case .success(let candlesticks):
                print("Candlesticks: \(candlesticks)")
            
            case .failure(let error):
                print(error)
            }
        }
    }
}
