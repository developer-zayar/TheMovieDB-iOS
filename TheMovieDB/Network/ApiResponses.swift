//
//  MovieResponse.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 23/01/2025.
//

struct MovieResponse: Decodable {
    let results: [Movie]
    let page: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
    }
}

struct MovieDates: Codable {
    let maximum: String?
    let minimum: String?
}

struct CastResponse: Decodable {
    let id: Int
    let cast: [Cast]
}

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct MovieVideoResponse: Decodable {
    let id: Int
    let results: [MovieVideo]
}

struct AuthResponse: Codable {
    let success: Bool
    let expiresAt: String?
    let requestToken: String?
    let sessionId: String?

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case sessionId = "session_id"
    }
}

struct ErrorResponse: Decodable {
    let success: Bool
    let status_code: Int
    let status_message: String?
}
