//
//  Endpoint.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 21/10/2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var parameters: [URLQueryItem] { get }
}

extension Endpoint {
    var components: URLComponents {
        var urlComponent = URLComponents(string: baseURL)
        urlComponent?.queryItems = parameters

        return urlComponent!
    }

    var request: URLRequest {
        return URLRequest(url: components.url!)
    }
}
