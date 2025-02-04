//
//  ProductionCountry.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

struct ProductionCountry: Codable {
    let iso31661: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1", name
    }
}
