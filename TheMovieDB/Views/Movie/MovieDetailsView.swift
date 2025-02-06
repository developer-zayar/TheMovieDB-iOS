//
//  MovieDetailsView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 25/01/2025.
//

import SwiftData
import SwiftUI

struct MovieDetailsView: View {
    let movieId: Int
    
    @Environment(\.modelContext)
    private var modelContext
    
    @StateObject private var viewModel: MovieViewModel = .init()
    @StateObject private var authViewModel: AuthViewModel = .init()
    
    @State private var isShowingTrailer = false
    @State private var selectedVideo: MovieVideo?
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Loading ...").frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if viewModel.errorMessage != nil {
                        ErrorView(message: viewModel.errorMessage)
                    } else if let movieDetails = viewModel.movieDetails {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 16) {
                                AsyncImage(url: ApiUrls.getImageURL(imagePath: movieDetails.backdropPath)) { image in
                                    image.resizable()
                                        .scaledToFill().frame(width: proxy.size.width)
                                        .frame(minHeight: proxy.size.height * 0.3, maxHeight: proxy.size.height * 0.3)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                        .scaledToFill().frame(width: proxy.size.width)
                                        .frame(minHeight: proxy.size.height * 0.3, maxHeight: proxy.size.height * 0.3)
                                }
                                .overlay(alignment: .center) {
                                    //                                Button(action: {
                                    //                                    isShowingTrailer.toggle()
                                    //                                }) {
                                    //                                    ZStack {
                                    //                                        Circle()
                                    //                                            .fill(Color.black.opacity(0.7))
                                    //                                            .frame(width: 40, height: 40)
                                    //
                                    //                                        Image(systemName: "play.fill")
                                    //                                            .font(.system(size: 16, weight: .bold))
                                    //                                            .foregroundColor(.white)
                                    //                                    }
                                    //                                }
                                }
                                    
                                // Movie Title, Release Date and Rating
                                HStack(alignment: .top, spacing: 16) {
                                    AsyncImage(url: ApiUrls.getImageURL(imagePath: movieDetails.posterPath)) { image in
                                        image.resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(8)
                                    .shadow(radius: 4)
                                        
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(movieDetails.originalTitle)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                            
                                        Text("Release: \(movieDetails.releaseDate)")
                                            .font(.subheadline)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.blue.opacity(0.2))
                                            .foregroundColor(.blue)
                                            .cornerRadius(8)
                                        
                                        Text("Duration: \(movieDetails.runtime) min")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                            
                                        HStack(spacing: 4) {
                                            Image(systemName: "star.fill")
                                                .font(.subheadline)
                                                .foregroundStyle(.yellow)
                                                
                                            Text("\(movieDetails.voteAverage, specifier: "%.1f") / \(movieDetails.voteCount) votes")
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
                                HStack {
                                    Button {
                                        viewModel.watchMovie(movie: movieDetails)
                                    } label: {
                                        Label("Watch Movie", systemImage: "play.circle.fill")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 14)
                                            .padding(.vertical, 8)
                                            .background(Color.tmdbSecondary)
                                            .clipShape(Capsule())
                                    }
                                    
                                    Button {
                                        if authViewModel.isLoggedIn {
                                            viewModel.toggleFavorite(modelContext: modelContext)
                                        } else {
                                            viewModel.alertMessage = "Please login to add movie to favorites"
                                            viewModel.showAlert.toggle()
                                        }
                                    } label: {
                                        Image(systemName: viewModel.movieDetails?.isFavorite == true ? "heart.fill" : "heart")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(12)
                                            .background(Color.tmdbSecondary)
                                            .clipShape(Circle())
                                    }
                                        
                                    Button {
                                        if authViewModel.isLoggedIn {
                                            viewModel.toggleWatchlist(modelContext: modelContext)
                                        } else {
                                            viewModel.alertMessage = "Please login to add movie to watchlist"
                                            viewModel.showAlert.toggle()
                                        }
                                    } label: {
                                        Image(systemName: viewModel.movieDetails?.isWatchlist == true ? "bookmark.fill" : "bookmark")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(12)
                                            .background(Color.tmdbSecondary)
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(.horizontal)
                                    
                                // Movie Genre
                                if let genres = movieDetails.genres {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Category")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 10) {
                                                ForEach(genres, id: \.id) { genre in
                                                    Text(genre.name)
                                                        .font(.caption)
                                                        .padding(.horizontal, 12)
                                                        .padding(.vertical, 6)
                                                        .background(Color.blue.opacity(0.2))
                                                        .foregroundColor(.blue)
                                                        .cornerRadius(12)
                                                }
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                    
                                // Movie Overview
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Overview")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        
                                    Text(movieDetails.overview)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(.horizontal)
                                
                                //                            switch viewModel.movieCastsState {
                                //                            case .idle, .loading:
                                //                                ProgressView()
                                //                                    .frame(maxWidth: .infinity, minHeight: 200)
                                //                            case .success(let casts):
                                //                                CastsView(casts: casts)
                                //                            case .error(let errorMessage):
                                //                                Text("Error: \(errorMessage)")
                                //                                    .foregroundColor(.red)
                                //                                    .padding()
                                //                            }
                                if case .success(let casts) = viewModel.movieCastsState, !casts.isEmpty {
                                    CastsView(casts: casts)
                                }
                                
                                if case .success(let videos) = viewModel.movieVideoState, !videos.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Preview Videos")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .padding(.horizontal)
                                    
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(alignment: .top, spacing: 16) {
                                                ForEach(videos) { video in
                                                    TrailerCardView(video: video)
                                                        .onTapGesture {
                                                            selectedVideo = video
                                                            isShowingTrailer = true
                                                        }
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        Text("No movie details available!")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            Task {
                await viewModel.fetchMovieDetails(movieId: self.movieId, modelContext: self.modelContext)
                await viewModel.fetchMovieCasts(movieId: self.movieId)
                await viewModel.fetchMovieVideos(movieId: self.movieId)
            }
        }
        .sheet(item: $selectedVideo) { video in
            YouTubeTrailerView(movieId: movieId, videoKey: video.key)
        }
        .alert(AppConstants.appName, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.alertMessage ?? "")
        }
    }
}

#Preview {
//    MovieDetailsView()
}
