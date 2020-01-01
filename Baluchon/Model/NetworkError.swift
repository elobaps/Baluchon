//
//  NetworkError.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 31/10/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

/// Enum for network call's error
enum NetworkError: Error {
    case domainError
    case invalidData
    case networkError
}
