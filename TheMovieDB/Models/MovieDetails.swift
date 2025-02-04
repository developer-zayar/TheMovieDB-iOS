//
//  Movie.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 23/01/2025.
//

import Foundation

struct MovieDetails: Codable, Identifiable {
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: Collection?
    let budget: Int
    let genres: [Genre]?
    let homepage: String?
    let imdbId: String?
    let originCountry: [String]?
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String
    let revenue: Int
    let runtime: Int
    let spokenLanguages: [SpokenLanguage]?
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id,
             adult,
             backdropPath = "backdrop_path",
             belongsToCollection = "belongs_to_collection",
             budget, genres, homepage,
             imdbId = "imdb_id",
             originCountry = "origin_country",
             originalLanguage = "original_language",
             originalTitle = "original_title",
             overview, popularity,
             posterPath = "poster_path",
             productionCompanies = "production_companies",
             productionCountries = "production_countries",
             releaseDate = "release_date",
             revenue,
             runtime,
             spokenLanguages = "spoken_languages",
             status,
             tagline,
             title,
             video,
             voteAverage = "vote_average",
             voteCount = "vote_count"
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }

    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
}
