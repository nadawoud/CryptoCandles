//
//  NetworkManager.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 21/10/2022.
//

import Foundation

protocol NetworkService {
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkManager: NetworkService {
    
    /// Excutes the network call and decodes the  JSON response into Codable object provided
    ///  - Parameters:
    ///     - endpoint: the enpoint to make the request against
    ///     - completion: closure that parses JSON into object provided
    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request) { data, response, error in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                print(error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            guard let responseObject = try? decoder.decode(T.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }

            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
        task.resume()
    }
}
