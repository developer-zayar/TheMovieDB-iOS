//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 30/01/2025.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movieListState: DataState<[Movie]> = .idle
    @Published var isLoadingMore: Bool = false
    @Published var currentPage: Int = 1
    @Published var totalPages: Int = 1

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let movieType: MovieType?
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository = MovieRepository(), movieType: MovieType? = nil) {
        self.movieRepository = movieRepository
        self.movieType = movieType
        print("MovieListViewModel init")
        Task {
            await fetchMovieList()
        }
    }

    func fetchMovieList() async {
        guard currentPage <= totalPages else {
            return
        }

        isLoadingMore = true
//        movieListState = .loading
        print("Fetching movie list...", terminator: "\n")

        do {
            let apiUrl = getApiUrl()
            print("MovieList API URL: \(apiUrl)", terminator: "\n")
            let response = try await movieRepository.fetchMovieList(urlString: apiUrl)
            let newMovies = response.results
            try? await Task.sleep(for: .seconds(2))
            print("Fetched movie list successfully.", terminator: "\n")
            print("Total pages: \(totalPages)", terminator: "\n")
            print("Current page: \(currentPage)", terminator: "\n")
            print("New movies count: \(newMovies.count)", terminator: "\n")

            switch movieListState {
            case .success(let currentMovies):
                movieListState = .success(AppUtils.removeDuplicateMovies(movies: currentMovies + newMovies))
            default:
                movieListState = .success(newMovies)
            }
            currentPage += 1
            totalPages = response.totalPages
        } catch {
//            movieListState = .error(error.localizedDescription)
            errorMessage = error.localizedDescription
            print("Error fetching movie list: \(error.localizedDescription)", terminator: "\n")
        }

        isLoadingMore = false
    }

    func getApiUrl() -> String {
        switch movieType {
        case .nowPlaying:
            return ApiUrls.nowPlayingMovies(page: currentPage)
        case .popular:
            return ApiUrls.popularMovies(page: currentPage)
        case .topRated:
            return ApiUrls.topRatedMovies(page: currentPage)
        case .upcoming:
            return ApiUrls.upcomingMovies(page: currentPage)
        case .discover:
            return ApiUrls.discoverMovies(page: currentPage)
        case .genre(let genreId):
            return ApiUrls.moviesByGenre(genreId: Int(genreId), page: currentPage)
        case .none:
            return ApiUrls.discoverMovies(page: currentPage)
        }
    }
}
