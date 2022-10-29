//
//  CandlestickChartPresenter.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 29/10/2022.
//

import Foundation

protocol CandlestickChartPresentationLogic {
    func presentFetchedCandlesticks(_ candlesticks: Candlesticks)
}

class CandlestickChartPresenter: CandlestickChartPresentationLogic {
    
    weak var viewController: CandlestickChartViewController?
    
    func presentFetchedCandlesticks(_ candlesticks: Candlesticks) {
        viewController?.displayFetchedCandlesticks(candlesticks)
    }
}
