//
//  Exchange.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 29/10/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

// MARK: - Exchange

struct ExchangeData: Decodable {
    let date: String
    let rates: [String: Float]
}
