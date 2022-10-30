//
//  CandlestickChartPresenter.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 29/10/2022.
//

import Foundation

protocol CandlestickChartPresentationLogic {
    func presentFetchedCandlesticks(_ candlesticks: Candlesticks)
    func presentFetchingError()
}

class CandlestickChartPresenter: CandlestickChartPresentationLogic {
    
    weak var viewController: CandlestickChartDisplayLogic?
    
    func presentFetchedCandlesticks(_ candlesticks: Candlesticks) {
        viewController?.displayFetchedCandlesticks(candlesticks)
    }
    
    func presentFetchingError() {
        viewController?.displayFetchingError()
    }
}
