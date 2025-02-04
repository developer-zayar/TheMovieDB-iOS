//
//  MovieSearchViewModel.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 30/01/2025.
//

import Foundation

@MainActor
class SearchMovieViewModel: ObservableObject {
    @Published var searchMovieList: DataState<[Movie]> = .idle
    @Published var searchQuery: String = ""

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository = MovieRepository()) {
        self.movieRepository = movieRepository
        print("MovieSearchViewModel Init")
    }

    func searchMovies() async {
        guard !searchQuery.isEmpty else {
            searchMovieList = .idle
            return
        }

        searchMovieList = .loading
        print("Searching for movies...")
        do {
            let movies = try await movieRepository.searchMovies(query: searchQuery)
            searchMovieList = .success(movies)
        } catch {
            searchMovieList = .error(error.localizedDescription)
        }
    }
}
