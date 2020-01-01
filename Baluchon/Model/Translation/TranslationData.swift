//
//  Translate.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 16/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

// MARK: - Data

struct TranslationData: Decodable {
    let data: DataClass
}

// MARK: - DataClass

struct DataClass: Decodable {
    let translations: [Translation]
}

// MARK: - Translation

struct Translation: Decodable {
    let translatedText: String
}
