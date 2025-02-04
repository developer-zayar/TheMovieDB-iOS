//
//  YouTubeTrailerView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 01/02/2025.
//

import SwiftUI

struct YouTubeTrailerView: View {
    let movieId: Int
    let videoKey: String

    @StateObject private var viewModel: MovieViewModel = .init()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                WebView(url: AppUtils.getYoutubeURL(key: videoKey))
                    .onAppear {
                        print("YoutubeTrailerView.onAppear: \(videoKey)")
                    }
                //            Text("Trailer")
                //                .font(.headline)
                //                .padding()

//                switch viewModel.movieVideoState {
//                case .idle, .loading:
//                    ProgressView("Loading ...")
//                case .success(let videos):
//                    if videos.isEmpty {
//                        Text("No Trailer Found")
//                            .foregroundColor(.gray)
//                            .padding()
//                    } else {
//                        WebView(url: AppUtils.getYoutubeURL(key: videos.first?.key ?? ""))
//                    }
//                case .error(let errorMessage):
//                    ErrorView(message: errorMessage)
//                }
            }
            .navigationTitle("Preview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
            }
            .task {
//                await viewModel.fetchMovieVideos(movieId: movieId)
            }
        }
    }
}

#Preview {
    YouTubeTrailerView(movieId: 438631, videoKey: "dQw4w9WgXcQ")
}
