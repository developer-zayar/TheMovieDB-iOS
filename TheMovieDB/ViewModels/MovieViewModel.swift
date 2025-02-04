//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

import Foundation

@MainActor
class MovieViewModel: ObservableObject {
    @Published var movieDetailsState: DataState<MovieDetails> = .idle
    @Published var movieCastsState: DataState<[Cast]> = .idle

    @Published var movieVideoState: DataState<[MovieVideo]> = .idle

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository = MovieRepository()) {
        self.movieRepository = movieRepository
        print("MovieViewModel Init")
    }

    func fetchMovieDetails(movieId: Int) async {
        movieDetailsState = .loading

        do {
            let movieDetails = try await movieRepository.fetchMovieDetails(id: movieId)
            movieDetailsState = .success(movieDetails)
        } catch {
            movieDetailsState = .error(error.localizedDescription)
        }
    }

    func fetchMovieCasts(movieId: Int) async {
        movieCastsState = .loading
        do {
            let casts = try await movieRepository.fetchMovieCasts(id: movieId)
            movieCastsState = .success(casts)
        } catch {
            movieCastsState = .error(error.localizedDescription)
        }
    }

    func fetchMovieVideos(movieId: Int) async {
        movieVideoState = .loading
        do {
            let videos = try await movieRepository.fetchMovieVideos(id: movieId)
            movieVideoState = .success(videos)
        } catch {
            movieVideoState = .error(error.localizedDescription)
        }
    }
}
