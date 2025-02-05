//
//  MovieRepository.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 24/01/2025.
//

import Foundation

class MovieRepository {
    private let apiService: ApiService

    init(apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }

    func fetchNowPlayingMovies() async throws -> [Movie] {
        let data = try await apiService.getRequest(url: ApiUrls.nowPlayingMovies())
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return movieResponse.results
    }

    func fetchPopularMovies() async throws -> [Movie] {
        let data = try await apiService.getRequest(url: ApiUrls.popularMovies())
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return movieResponse.results
    }

    func fetchTopRatedMovies() async throws -> [Movie] {
        let data = try await apiService.getRequest(url: ApiUrls.topRatedMovies())
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return movieResponse.results
    }

    func fetchUpcomingMovies() async throws -> [Movie] {
        let data = try await apiService.getRequest(url: ApiUrls.upcomingMovies())
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return movieResponse.results
    }

    func fetchMovieDetails(id: Int) async throws -> Movie {
        print(ApiUrls.movieDetails(movieId: id))
        let data = try await apiService.getRequest(url: ApiUrls.movieDetails(movieId: id))
        let movieDetailsResponse = try JSONDecoder().decode(Movie.self, from: data)
        return movieDetailsResponse
    }

    func fetchMovieCasts(id: Int) async throws -> [Cast] {
        let data = try await apiService.getRequest(url: ApiUrls.movieCasts(movieId: id))
        let castResponse = try JSONDecoder().decode(CastResponse.self, from: data)
        return castResponse.cast
    }

    func fetchMovieVideos(id: Int) async throws -> [MovieVideo] {
        let data = try await apiService.getRequest(url: ApiUrls.movieVideos(movieId: id))
        let castResponse = try JSONDecoder().decode(MovieVideoResponse.self, from: data)
        return castResponse.results
    }

    func searchMovies(query: String) async throws -> [Movie] {
        print(ApiUrls.searchMovies(query: query))
        let data = try await apiService.getRequest(url: ApiUrls.searchMovies(query: query))
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return movieResponse.results
    }

    func fetchMovieList(urlString: String) async throws -> MovieResponse {
        let data = try await apiService.getRequest(url: urlString)
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        return response
    }

    func fetchMovieGenres() async throws -> [Genre] {
        let data = try await apiService.getRequest(url: ApiUrls.movieGenres)
        let genreResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
        return genreResponse.genres
    }


}
