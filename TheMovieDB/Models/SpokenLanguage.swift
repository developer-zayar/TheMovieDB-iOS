//
//  SpokenLanguage.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

struct SpokenLanguage: Codable {
    let englishName: String
    let iso6391: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name", iso6391 = "iso_639_1", name
    }
}
