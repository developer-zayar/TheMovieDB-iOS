//
//  HomeViewModel.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 24/01/2025.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []

    @Published var movieGenres: [Genre] = []

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository = MovieRepository()) {
        self.movieRepository = movieRepository
    }

    func fetchMovies() async {
        if !self.nowPlayingMovies.isEmpty {
            return
        }

        print("Fetching Movies ...")
        do {
            let movies = try await movieRepository.fetchNowPlayingMovies()
            self.nowPlayingMovies = movies
            print("Movies:\(movies.count)")
        } catch {
            self.errorMessage = "Error fetching NowPlayingMovies: \(error.localizedDescription)"
//            print(self.errorMessage)
        }

        do {
            let movies = try await movieRepository.fetchPopularMovies()
            self.popularMovies = movies
        } catch {
            self.errorMessage = "Error fetching PopularMovies: \(error.localizedDescription)"
        }

        do {
            let movies = try await movieRepository.fetchTopRatedMovies()
            self.topRatedMovies = movies
        } catch {
            self.errorMessage = "Error fetching TopRatedMovies: \(error.localizedDescription)"
        }

        do {
            let movies = try await movieRepository.fetchUpcomingMovies()
            self.upcomingMovies = movies
        } catch {
            self.errorMessage = "Error fetching UpcomingMovies: \(error.localizedDescription)"
        }

        do {
            let genres = try await movieRepository.fetchMovieGenres()
            self.movieGenres = genres
        } catch {
            print("Error fetching MovieGenres: \(error.localizedDescription)")
        }
    }
}
