//
//  MovieSummary.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

import Foundation
import SwiftData

@Model
class Movie: Codable, Identifiable {
    @Attribute(.unique) var id: Int
    var adult: Bool
    var backdropPath: String?
    var genreIds: [Int]?
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var popularity: Double
    var posterPath: String?
    var releaseDate: String
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int

    // Added by Movie Details
    var belongsToCollection: Collection?
    var budget: Int
    var genres: [Genre]?
    var homepage: String?
    var imdbId: String?
    var originCountry: [String]?
    var productionCompanies: [ProductionCompany]?
    var productionCountries: [ProductionCountry]?
    var revenue: Int
    var runtime: Int
    var spokenLanguages: [SpokenLanguage]?
    var status: String
    var tagline: String

    var isFavorite: Bool?
    var isWatchlist: Bool?

    // MARK: - Codable Conformance

    enum CodingKeys: String, CodingKey {
        case id, adult, overview, popularity, title, video, budget, homepage, revenue, runtime, status, tagline
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case isFavorite
        case belongsToCollection = "belongs_to_collection"
        case genres, imdbId = "imdb_id"
        case originCountry = "origin_country"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case spokenLanguages = "spoken_languages"
    }

    // MARK: - Initializer for SwiftData

    init(id: Int, adult: Bool, backdropPath: String? = nil, genreIds: [Int]? = nil, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String? = nil, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Int, belongsToCollection: Collection? = nil, budget: Int = 0, genres: [Genre]? = nil, homepage: String? = nil, imdbId: String? = nil, originCountry: [String]? = nil, productionCompanies: [ProductionCompany]? = nil, productionCountries: [ProductionCountry]? = nil, revenue: Int = 0, runtime: Int = 0, spokenLanguages: [SpokenLanguage]? = nil, status: String = "", tagline: String = "",
         isFavorite: Bool? = false, isWatchlist: Bool? = false)
    {
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.imdbId = imdbId
        self.originCountry = originCountry
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.isFavorite = isFavorite
        self.isWatchlist = isWatchlist
    }

    // MARK: - Decoding (From JSON to SwiftData Model)

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        adult = try container.decode(Bool.self, forKey: .adult)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) ?? nil
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        title = try container.decode(String.self, forKey: .title)
        video = try container.decode(Bool.self, forKey: .video)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        belongsToCollection = try container.decodeIfPresent(Collection.self, forKey: .belongsToCollection)
        budget = try container.decodeIfPresent(Int.self, forKey: .budget) ?? 0
        genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        imdbId = try container.decodeIfPresent(String.self, forKey: .imdbId)
        originCountry = try container.decodeIfPresent([String].self, forKey: .originCountry) ?? nil
        productionCompanies = try container.decodeIfPresent([ProductionCompany].self, forKey: .productionCompanies)
        productionCountries = try container.decodeIfPresent([ProductionCountry].self, forKey: .productionCountries)
        revenue = try container.decodeIfPresent(Int.self, forKey: .revenue) ?? 0
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime) ?? 0
        spokenLanguages = try container.decodeIfPresent([SpokenLanguage].self, forKey: .spokenLanguages)
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline) ?? ""
    }

    // MARK: - Encoding (From SwiftData Model to JSON)

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(adult, forKey: .adult)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encode(genreIds, forKey: .genreIds)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(title, forKey: .title)
        try container.encode(video, forKey: .video)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encodeIfPresent(belongsToCollection, forKey: .belongsToCollection)
        try container.encode(budget, forKey: .budget)
        try container.encodeIfPresent(genres, forKey: .genres)
        try container.encodeIfPresent(homepage, forKey: .homepage)
        try container.encodeIfPresent(imdbId, forKey: .imdbId)
        try container.encodeIfPresent(originCountry, forKey: .originCountry)
        try container.encodeIfPresent(productionCompanies, forKey: .productionCompanies)
        try container.encodeIfPresent(productionCountries, forKey: .productionCountries)
        try container.encode(revenue, forKey: .revenue)
        try container.encode(runtime, forKey: .runtime)
        try container.encodeIfPresent(spokenLanguages, forKey: .spokenLanguages)
        try container.encode(status, forKey: .status)
        try container.encode(tagline, forKey: .tagline)
    }
}
