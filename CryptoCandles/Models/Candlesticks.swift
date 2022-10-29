//
//  Candlesticks.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 21/10/2022.
//

import Foundation

enum CandlestickComponent: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(CandlestickComponent.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ChartElement"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    
    func asDouble() -> Double {
        switch self {
        case .integer(let component):
            return Double(component)
        case .string(let component):
            guard let double = Double(component) else { return Double(0) }
            return double
        }
    }
}

typealias Candlestick = [CandlestickComponent]
typealias Candlesticks = [Candlestick]
