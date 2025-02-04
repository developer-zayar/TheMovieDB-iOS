//
//  MovieHorizontalScrollView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 24/01/2025.
//

import SwiftUI

struct MovieHorizontalScrollView: View {
    let title: String
    let movies: [Movie]

    @State private var selectedMovie: Movie?
    @State private var isShowingDetails: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Spacer()

                NavigationLink(destination: MovieListView(title: title)) {
                    Text("View More")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(movies) { movie in
                        MovieCardView(movie: movie)
                            .onTapGesture {
                                selectedMovie = movie
                                isShowingDetails = true
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationDestination(isPresented: $isShowingDetails) {
            if let selectedMovie {
                MovieDetailsView(movieId: selectedMovie.id)
            }
        }
    }
}

#Preview {
//    MovieHorizontalScrollView()
}
