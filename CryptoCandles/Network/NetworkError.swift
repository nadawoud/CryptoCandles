//
//  NetworkError.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 30/10/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case unableToComplete
    case invalidData
    case decodingError
    case unknownError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response."
        case .unableToComplete:
            return "Unable to complete your request. Check your internet connection."
        case .invalidData:
            return "Data received from the server was invalid."
        case .decodingError:
            return "Unable to decode JSON object."
        case .unknownError:
            return "Something went wrong, please try again later."
        }
    }
}
