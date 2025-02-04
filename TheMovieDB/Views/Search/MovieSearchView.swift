//
//  MovieSearchView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 27/01/2025.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject private var viewModel: SearchMovieViewModel = .init()

    @State private var testcount: Int = 0

    var body: some View {
        NavigationStack {
            VStack {
//                TextField("Search Movies ...", text: $viewModel.searchQuery)
//                    .textFieldStyle(.roundedBorder)
//                    .autocorrectionDisabled()
//                    .autocapitalization(.none)
//                    .padding()
//                    .onSubmit {
//                        Task {
//                            await viewModel.searchMovies()
//                        }
//                    }

                SearchBarView(searchText: $viewModel.searchQuery)
                    .onSubmit {
                        Task {
                            await viewModel.searchMovies()
                        }
                    }

                Group {
                    switch viewModel.searchMovieList {
                    case .idle:
                        MovieListView(title: "Search Movies")
                    case .loading:
                        ProgressView("Loading ...")
                    case .success(let movies):
                        if movies.isEmpty {
                            Text("No Result Found!\nTry another.")
                                .multilineTextAlignment(.center)
                        } else {
                            MovieGridView(movies: movies)
                        }
                    case .error(let errorMessage):
                        ErrorView(message: errorMessage)
                    }
                }
                .padding(.top, 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationBarTitle("Search Movies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
//    MovieSearchView()
}
