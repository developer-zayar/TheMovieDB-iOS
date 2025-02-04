//
//  MovieVideo.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 01/02/2025.
//

struct MovieVideo: Codable, Identifiable {
    let id: String
    let iso639_1: String
    let iso3166_1: String
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case key
        case site
        case size
        case type
        case official
        case publishedAt = "published_at"
    }
}
