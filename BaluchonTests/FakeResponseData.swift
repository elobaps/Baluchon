//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Elodie-Anne Parquer on 05/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

final class FakeResponseData {
    
     // MARK: - Response

    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.google.com/")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.google.com/")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)

     // MARK: - Error

    class ExchangeError: Error {}
    static let error = ExchangeError()
    
    class WeatherError: Error {}
    static let errorWeather = WeatherError()
    
    class TranslateError: Error {}
    static let errorTranslate = TranslateError()

    // MARK: - Data
    
    /// Exchange
    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Exchange", withExtension: "json")
        guard let data = try? Data(contentsOf: url!) else {
            fatalError("Exchange.json can't be loaded !")
        }
        return data
    }
    
    /// Weather
    static var weatherCorrectData: Data {
         let bundle = Bundle(for: FakeResponseData.self)
         let url = bundle.url(forResource: "Weather", withExtension: "json")
         guard let data = try? Data(contentsOf: url!) else {
            fatalError("Weather.json can't be loaded !")
         }
         return data
     }
    
    /// Translate
    static var translateCorrectData: Data {
         let bundle = Bundle(for: FakeResponseData.self)
         let url = bundle.url(forResource: "Translate", withExtension: "json")
         guard let data = try? Data(contentsOf: url!) else {
            fatalError("Translate.json can't be loaded !")
         }
         return data
     }
    
    static var translateLanguagesCorrectData: Data {
            let bundle = Bundle(for: FakeResponseData.self)
            let url = bundle.url(forResource: "Languages", withExtension: "json")
            guard let data = try? Data(contentsOf: url!) else {
               fatalError("Languages.json can't be loaded !")
            }
            return data
        }
    
    /// Incorrect Data
    static let exchangeIncorrectData = "erreur".data(using: .utf8)!
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    
    static let translateInccorectDate = "erreur".data(using: .utf8)
}
