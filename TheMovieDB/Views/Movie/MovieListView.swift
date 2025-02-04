//
//  MovieListView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 27/01/2025.
//

import SwiftUI

struct MovieListView: View {
    let title: String?
    let movieType: MovieType?

    @StateObject private var viewModel: MovieListViewModel

    init(title: String? = nil, movieType: MovieType? = .discover) {
        self.title = title
        self.movieType = movieType

        _viewModel = StateObject(wrappedValue: MovieListViewModel(movieType: movieType))
    }

    let columns = [
        GridItem(.adaptive(minimum: 120, maximum: 120), spacing: 8, alignment: .top)
    ]

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.movieListState {
                case .idle, .loading:
                    ProgressView("Loading ...")
                case .success(let data):
                    ScrollView(showsIndicators: true) {
                        LazyVGrid(columns: columns) {
                            ForEach(data) { movie in
                                NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                                    MovieCardView(movie: movie)
                                        .onAppear {
                                            if movie.id == data.last?.id {
                                                print("FetchMovieList from card view")
                                                Task {
                                                    await viewModel.fetchMovieList()
                                                }
                                            }
                                        }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 8)

                        if viewModel.isLoadingMore {
                            ProgressView("Loading ...")
                                .padding()
                        }
                    }
                case .error(let errorMessage):
                    ErrorView(message: errorMessage)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(title ?? "")
            .onAppear {
//                Task {
//                    await viewModel.fetchMovieList()
//                }
            }
        }
    }
}

#Preview {
//    MovieListView()
}
