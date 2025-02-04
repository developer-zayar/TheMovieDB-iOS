//
//  Collection.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

struct Collection: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, posterPath = "poster_path", backdropPath = "backdrop_path"
    }
}
