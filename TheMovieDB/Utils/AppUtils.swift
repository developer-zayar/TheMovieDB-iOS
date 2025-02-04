//
//  AppUtils.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 27/01/2025.
//

import Foundation

class AppUtils {
    static func removeDuplicateMovies(movies: [Movie]) -> [Movie] {
        var seenIds = Set<Int>()
        return movies.filter { seenIds.insert($0.id).inserted }
    }

    static func getYoutubeURL(key: String) -> URL? {
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }

    static func getYoutubeThumbnail(key: String) -> URL? {
        guard !key.isEmpty else { return nil }
        return URL(string: "https://img.youtube.com/vi/\(key)/hqdefault.jpg")
    }

    static var tmdbSignupUrl: URL? {
        URL(string: "https://www.themoviedb.org/authenticate/")
    }
}
