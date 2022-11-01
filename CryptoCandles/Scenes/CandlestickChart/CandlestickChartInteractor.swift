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

protocol CryptoCandlesService {
    func fetchCandlesticks(forCurrency currency: CryptoCurrency, completion: @escaping (Result<Candlesticks, NetworkError>) -> Void)
}

class CandlestickChartInteractor: CandlestickChartBusinessLogic, CryptoCandlesService {
    
    var presenter: CandlestickChartPresentationLogic?
    
    func fetchCandlesticks(forCurrency currency: CryptoCurrency, completion: @escaping (Result<Candlesticks, NetworkError>) -> Void) {
        let networkManager = NetworkManager()
       
        return networkManager.request(endpoint: CryptoCandleEndpoint.getCandlestickChartData(currency: currency), completion: completion)
    }
    
    func fetchChartData(forCurrency currency: CryptoCurrency) {
        
        fetchCandlesticks(forCurrency: currency) { [weak self] (result: Result<Candlesticks, NetworkError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let candlesticks):
                print("Candlesticks: \(candlesticks)")
                self.presenter?.presentFetchedCandlesticks(candlesticks)
                
            case .failure(let error):
                print(error)
                self.presenter?.presentFetchingError()
            }
        }
    }
}
