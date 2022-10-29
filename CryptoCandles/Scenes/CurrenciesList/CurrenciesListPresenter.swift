//
//  CurrenciesListPresenter.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 29/10/2022.
//

import Foundation

protocol CurrenciesListPresentationLogic {
    func presentCurrencies(_ currencies: [CryptoCurrency])
}


class CurrenciesListPresenter: CurrenciesListPresentationLogic {
    
    weak var viewController: CurrenciesListDisplayLogic?
    
    func presentCurrencies(_ currencies: [CryptoCurrency]) {
        viewController?.displayCurrencies(currencies)
    }
}
