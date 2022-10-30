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
    var presenter: CandlestickChartPresentationLogic?
    
    func fetchChartData(forCurrency currency: CryptoCurrency) {
        
        NetworkManager.request(endpoint: CryptoCandleEndpoint.getCandlestickChartData(currency: currency)) { [weak self] (result: Result<Candlesticks, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let candlesticks):
                print("Candlesticks: \(candlesticks)")
                self.presenter?.presentFetchedCandlesticks(candlesticks)
            
            case .failure(let error):
                print(error)
            }
        }
    }
}
