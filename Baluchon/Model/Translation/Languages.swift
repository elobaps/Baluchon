//
//  Languages.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 22/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Languages: Decodable {
    let data: LanguagesData
}

// MARK: - DataClass
struct LanguagesData: Decodable {
    let languages: [Language]
}

// MARK: - Language
struct Language: Decodable {
    let language: String
}
