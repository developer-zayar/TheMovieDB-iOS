//
//  MovieListView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 27/01/2025.
//

import SwiftUI

struct MovieGridView: View {
    let movies: [Movie]

    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 8, alignment: .top)
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                        MovieCardView(movie: movie)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
//    MovieGridView()
}
