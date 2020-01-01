//
//  WeatherService.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 11/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

final class WeatherService: EncoderUrl {
    
    // MARK: - Properties
    
    private var weatherSession: URLSession
    private var task: URLSessionDataTask?

    init(session: URLSession = URLSession(configuration: .default)) {
        weatherSession = session
    }

    // MARK: - Method
    
    /// network call
    func getWeather(callback: @escaping (Result<WeatherData, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: "http://api.openweathermap.org/data/2.5/group") else { return }
        
        let parameters: [(String, String)] = [("id", "5128638,6455058"), ("APPID", ApiConfig.openWeatherMapApiKey), ("units", "metric"), ("lang", "fr")]
               let url = encode(baseUrl: baseUrl, parameters: parameters)

        task?.cancel()
        task = weatherSession.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    callback(.failure(.networkError))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.networkError))
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                        callback(.failure(.invalidData))
                        return
                }
                callback(.success(responseJSON))
            }
            task?.resume()
        }
}
