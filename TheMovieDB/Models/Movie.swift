//
//  MovieSummary.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

import Foundation

struct Movie: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    var posterURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }

    var backdropURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")
    }
}
