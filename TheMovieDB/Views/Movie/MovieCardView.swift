//
//  MovieCardView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 24/01/2025.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack {
            AsyncImage(url: movie.posterURL) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .overlay {
                        Image(systemName: "film")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray)
                            .frame(height: 60)
                    }
            }
            .frame(height: 180)
            .cornerRadius(8)

            Text("\(movie.title)")
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.caption)

                Text("\(movie.voteAverage, specifier: "%.1f")")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 120)
    }
}

#Preview {
//    MovieCardView(Movie())
}
