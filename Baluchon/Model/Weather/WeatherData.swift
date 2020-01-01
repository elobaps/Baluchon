//
//  Weather.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 11/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

// MARK: - Weather Structure

struct WeatherData: Decodable {
    let cnt: Int
    let list: [List]
}

// MARK: - List

struct List: Decodable {
    let id: Int
    let weather: [Weather]
    let main: Main
    let name: String
}

// MARK: - Main

struct Main: Decodable {
    let temp: Double
}

// MARK: - Weather

struct Weather: Decodable {
    let weatherDescription, icon: String?
    
    enum CodingKeys: String, CodingKey {
           case weatherDescription = "description"
           case icon
    }
}
