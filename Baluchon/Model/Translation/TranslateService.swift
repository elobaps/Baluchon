//
//  TranslateService.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 16/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

final class TranslateService: EncoderUrl {
    
    // MARK: - Properties
    
    private var translateSession: URLSession
    private var task: URLSessionDataTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        translateSession = session
    }
    
    // MARK: - Methods
    
    /// network call
    func getTranslation(text: String, target: String, callback: @escaping (Result<TranslationData, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: "https://translation.googleapis.com/language/translate/v2")
            else { return }
        
        let parameters: [(String, String)] = [("key", ApiConfig.googleApiKey), ("q", text), ("source", "fr"), ("target", target), ("format", "text")]
        let url = encode(baseUrl: baseUrl, parameters: parameters)
        
        task?.cancel()
        task = translateSession.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                callback(.failure(.networkError))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.networkError))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(TranslationData.self, from: data) else {
                callback(.failure(.invalidData))
                return
            }
            callback(.success(responseJSON))
        }
        task?.resume()
    }
    
    func getLanguages(callback: @escaping (Result<Languages, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: "https://translation.googleapis.com/language/translate/v2/languages")
            else { return }
        
        let parameters: [(String, String)] = [("key", ApiConfig.googleApiKey)]
        let languagesUrl = encode(baseUrl: baseUrl, parameters: parameters)
        
        task?.cancel()
        task = translateSession.dataTask(with: languagesUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                callback(.failure(.networkError))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.networkError))
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(Languages.self, from: data) else {
                callback(.failure(.invalidData))
                return
            }
            callback(.success(responseJSON))
        }
        task?.resume()
    }
}
