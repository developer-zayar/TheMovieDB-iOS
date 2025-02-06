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
//    @Published var movieDetailsState: DataState<Movie> = .idle
    @Published var movieCastsState: DataState<[Cast]> = .idle
    @Published var movieVideoState: DataState<[MovieVideo]> = .idle

    @Published var movieDetails: Movie?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    @Published var alertMessage: String?

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository = MovieRepository()) {
        self.movieRepository = movieRepository
        print("MovieViewModel Init")
    }

    func fetchMovieDetails(movieId: Int, modelContext: ModelContext) async {
//        movieDetailsState = .loading
        isLoading = true

        do {
            let movieDetails = try await movieRepository.fetchMovieDetails(id: movieId)
//            movieDetailsState = .success(movieDetails)
            if let existingMovie = fetchMovieFromSwiftData(id: movieId, modelContext: modelContext) {
                movieDetails.isFavorite = existingMovie.isFavorite
                movieDetails.isWatchlist = existingMovie.isWatchlist
            } else {
                modelContext.insert(movieDetails)
            }

            self.movieDetails = movieDetails
            isLoading = false

        } catch {
//            movieDetailsState = .error(error.localizedDescription)
            isLoading = false
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

    func toggleFavorite(modelContext: ModelContext) {
        guard let movieDetails else { return }

        if movieDetails.isFavorite {
            movieDetails.isFavorite = false
            modelContext.delete(movieDetails)

            alertMessage = "Removed from Favorites"
            showAlert.toggle()
        } else {
            movieDetails.isFavorite = true
            modelContext.insert(movieDetails)

            alertMessage = "Added to Favorites"
            showAlert.toggle()
        }
        saveContext(modelContext)
    }

    func toggleWatchlist(modelContext: ModelContext) {
        guard let movieDetails else { return }

        if movieDetails.isWatchlist {
            movieDetails.isWatchlist = false
            modelContext.delete(movieDetails)

            alertMessage = "Removed from Watchlist"
            showAlert.toggle()
        } else {
            movieDetails.isWatchlist = true
            modelContext.insert(movieDetails)

            alertMessage = "Added to Watchlist"
            showAlert.toggle()
        }
        saveContext(modelContext)
    }

    // Simulate Watching Movie
    func watchMovie(movie: Movie) {
        print("Watching \(movie.title)...")
        alertMessage = "Coming soon ..."
        showAlert = true
    }

    private func fetchMovieFromSwiftData(id: Int, modelContext: ModelContext) -> Movie? {
        let descriptor = FetchDescriptor<Movie>(predicate: #Predicate { $0.id == id })
        do {
            return try modelContext.fetch(descriptor).first
        } catch {
            print("Failed to fetch movie from SwiftData: \(error)")
            return nil
        }
    }

    private func saveContext(_ modelContext: ModelContext) {
        do {
            try modelContext.save()
            print("Changes saved successfully!")
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
}
