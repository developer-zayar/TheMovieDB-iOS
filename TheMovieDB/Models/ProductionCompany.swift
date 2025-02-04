//
//  ProductionCompany.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id, logoPath = "logo_path", name, originCountry = "origin_country"
    }
}
