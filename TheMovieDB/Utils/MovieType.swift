//
//  MovieType.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 31/01/2025.
//

import Foundation

enum MovieType: CaseIterable {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case discover
    case genre(Int)

    var rawValue: String {
        switch self {
        case .nowPlaying: return "now_playing"
        case .popular: return "popular"
        case .topRated: return "top_rated"
        case .upcoming: return "upcoming"
        case .discover: return "discover"
        case .genre(let id): return "\(id)"
        }
    }

    var displayName: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        case .discover: return "Discover"
        case .genre(let id): return "Genre \(id)"
        }
    }

    static var allCases: [MovieType] {
        return [.nowPlaying, .popular, .topRated, .upcoming, .discover]
    }
}
