//
//  UserProfile.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 01/02/2025.
//

import Foundation

struct UserProfile: Codable {
    let id: Int
    let avatar: Avatar?
    let iso639_1: String?
    let iso3166_1: String?
    let name: String?
    let includeAdult: Bool
    let username: String?

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

struct Avatar: Codable {
    let gravatar: Gravatar?
    let tmdb: TMDB?
}

struct Gravatar: Codable {
    let hash: String?
}

struct TMDB: Codable {
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}
