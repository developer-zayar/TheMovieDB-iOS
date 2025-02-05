//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

import Foundation
import SwiftData

@MainActor
class MovieViewModel: ObservableObject {
    @Published var movieDetailsState: DataState<Movie> = .idle
    @Published var movieCastsState: DataState<[Cast]> = .idle
    @Published var movieVideoState: DataState<[MovieVideo]> = .idle

    @Published var movieDetails: Movie?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false

    private var modelContext: ModelContext? = nil
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository = MovieRepository()) {
        self.movieRepository = movieRepository
        print("MovieViewModel Init")
    }

    func setModelContext(_ context: ModelContext) {
        modelContext = context
    }

    func fetchMovieDetails(movieId: Int) async {
        movieDetailsState = .loading
        isLoading = true

        do {
            let movieDetails = try await movieRepository.fetchMovieDetails(id: movieId)
            movieDetailsState = .success(movieDetails)

            if let existingMovie = fetchMovieFromSwiftData(id: movieId) {
                movieDetails.isFavorite = existingMovie.isFavorite
                movieDetails.isWatchlist = existingMovie.isWatchlist
            }

            self.movieDetails = movieDetails

        } catch {
            movieDetailsState = .error(error.localizedDescription)
            errorMessage = "Failed to load movie details:\n\(error.localizedDescription)"
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

    func toggleFavorite() {
        guard let movie = movieDetails, let modelContext = modelContext else { return }
        if movie.isFavorite == true {
            movieDetails?.isFavorite = false
            modelContext.delete(movie)
        } else {
            movieDetails?.isFavorite = true
            movie.isFavorite = true
            if fetchMovieFromSwiftData(id: movie.id) == nil {
                modelContext.insert(movie)
            }
        }
        saveContext()
    }

    func toggleWatchlist() {
        guard let movie = movieDetails, let modelContext = modelContext else { return }

        if movie.isWatchlist == true {
            movieDetails?.isWatchlist = false
            modelContext.delete(movie)
        } else {
            movieDetails?.isWatchlist = true
            movie.isWatchlist = true
            if fetchMovieFromSwiftData(id: movie.id) == nil {
                modelContext.insert(movie)
            }
        }

        saveContext()
    }

    // Simulate Watching Movie
    func watchMovie(movie: Movie) {
        print("Watching \(movie.title)...")
        showAlert = true
    }

    private func fetchMovieFromSwiftData(id: Int) -> Movie? {
        let descriptor = FetchDescriptor<Movie>(predicate: #Predicate { $0.id == id })
        do {
            return try modelContext?.fetch(descriptor).first
        } catch {
            print("Failed to fetch movie from SwiftData: \(error)")
            return nil
        }
    }

    private func saveContext() {
        do {
            try modelContext?.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
