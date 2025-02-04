//
//  APIURLs.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 23/01/2025.
//

import Foundation

class ApiUrls {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "0ed3869fc7fb19aabd8db49627211de6"

    // Movie Endpoints
    static func discoverMovies(page: Int = 1) -> String {
        "\(baseURL)/discover/movie?api_key=\(apiKey)&include_adult=false&include_video=false&language=en-US&page=\(page)&sort_by=popularity.desc"
    }

    static func nowPlayingMovies(page: Int = 1) -> String {
        "\(baseURL)/movie/now_playing?api_key=\(apiKey)&language=en-US&page=\(page)"
    }

    static func popularMovies(page: Int = 1) -> String {
        "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=\(page)"
    }

    static func topRatedMovies(page: Int = 1) -> String {
        "\(baseURL)/movie/top_rated?api_key=\(apiKey)&language=en-US&page=\(page)"
    }

    static func upcomingMovies(page: Int = 1) -> String {
        "\(baseURL)/movie/upcoming?api_key=\(apiKey)&language=en-US&page=\(page)"
    }

    static func movieDetails(movieId: Int) -> String {
        "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)&language=en-US"
    }

    static func movieCasts(movieId: Int) -> String {
        "\(baseURL)/movie/\(movieId)/credits?api_key=\(apiKey)&language=en-US"
    }

    static func movieVideos(movieId: Int) -> String {
        "\(baseURL)/movie/\(movieId)/videos?api_key=\(apiKey)&language=en-US"
    }

    // Search
    static func searchMovies(query: String) -> String {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return "\(baseURL)/search/movie?api_key=\(apiKey)&language=en-US&query=\(encodedQuery)&page=1&include_adult=false"
    }

    static var movieGenres: String {
        "\(baseURL)/genre/movie/list?api_key=\(apiKey)&language=en-US"
    }

    static func moviesByGenre(genreId: Int, page: Int = 1) -> String {
        "\(baseURL)/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&with_genres=\(genreId)&page=\(page)"
    }

    // Authentication
    static var requestToken: String {
        "\(baseURL)/authentication/token/new?api_key=\(apiKey)"
    }

    static var validateLogin: String {
        "\(baseURL)/authentication/token/validate_with_login?api_key=\(apiKey)"
    }

    static var createSession: String {
        "\(baseURL)/authentication/session/new?api_key=\(apiKey)"
    }

    static func getUserProfile(sessionId: String) -> String {
        "\(baseURL)/account?api_key=\(apiKey)&session_id=\(sessionId)"
    }

    // ImageURL
    static func getImageURL(imagePath: String?) -> URL? {
        guard let imagePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")
    }
}
