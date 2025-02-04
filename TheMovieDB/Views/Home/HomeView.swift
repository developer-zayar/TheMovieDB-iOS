//
//  HomeView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 24/01/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel: HomeViewModel = .init()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    if !homeViewModel.nowPlayingMovies.isEmpty {
                        Text("Now Playing")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        AutoImageSliderView(movies: homeViewModel.nowPlayingMovies, timeInterval: 5)
                    }

                    if !homeViewModel.movieGenres.isEmpty {
                        GenresView(title: "Category", genres: homeViewModel.movieGenres)
                    }

                    if !homeViewModel.popularMovies.isEmpty {
                        MovieHorizontalScrollView(title: "Popular", movies: homeViewModel.popularMovies)
                    }

                    if !homeViewModel.topRatedMovies.isEmpty {
                        MovieHorizontalScrollView(title: "Top Rated", movies: homeViewModel.topRatedMovies)
                    }

                    if !homeViewModel.upcomingMovies.isEmpty {
                        MovieHorizontalScrollView(title: "Upcoming", movies: homeViewModel.upcomingMovies)
                    }
                }
            }
            .navigationTitle("TheMovieDB")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(Color.tmdbPrimary, for: .navigationBar)
            .onAppear {
                Task {
                    await homeViewModel.fetchMovies()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
