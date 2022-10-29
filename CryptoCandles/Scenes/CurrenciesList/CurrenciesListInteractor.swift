//
//  CurrenciesListInteractor.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 29/10/2022.
//

import Foundation

protocol CurrenciesListBusinessLogic {
    func getCurrencies()
}

class CurrenciesListInteractor: CurrenciesListBusinessLogic {
    
    var presenter: CurrenciesListPresentationLogic?
    
    func getCurrencies() {
        let currencies = CryptoCurrency.allCases
        presenter?.presentCurrencies(currencies)
    }
}
