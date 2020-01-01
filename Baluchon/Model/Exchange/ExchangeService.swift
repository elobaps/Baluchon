//
//  ExchangeService.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 29/10/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

final class ExchangeService: EncoderUrl {
    
    // MARK: - Properties
    
    private var exchangeSession: URLSession
    private var task: URLSessionDataTask?

    init(session: URLSession = URLSession(configuration: .default)) {
        exchangeSession = session
    }

    // MARK: - Method
    
    /// network call
    func getRate(callback: @escaping (Result<ExchangeData, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: "http://data.fixer.io/api/latest") else { return }

        let parameters: [(String, String)] = [("access_key", ApiConfig.fixerApiKey), ("base", "EUR"), ("symbols", "USD")]
        let url = encode(baseUrl: baseUrl, parameters: parameters)

        task?.cancel()
        task = exchangeSession.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                callback(.failure(.networkError))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.networkError))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(ExchangeData.self, from: data) else {
                callback(.failure(.invalidData))
                return
            }
            callback(.success(responseJSON))
        }
        task?.resume()
    }
}
