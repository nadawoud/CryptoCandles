//
//  CryptoCandleEndpoint.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 21/10/2022.
//

import Foundation

enum CryptoCurrency: String {
    case btc = "BTCUSDT"
    case ltc = "LTCUSDT"
    case eth = "ETHUSDT"
}

enum CryptoCandleEndpoint: Endpoint {
    case getCandlestickChartData(currency: CryptoCurrency)
    
    var baseURL: String {
        switch self {
        default:
            return "https://fapi.binance.com/fapi/v1/klines"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getCandlestickChartData(let currency):
            return [URLQueryItem(name: "symbol", value: currency.rawValue),
                    URLQueryItem(name: "interval", value: "15m"),
                    URLQueryItem(name: "limit", value: "100")]
        }
    }
}
