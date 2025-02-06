//
//  MovieListItemView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 05/02/2025.
//

import SwiftUI

struct MovieListItemView: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Movie Poster
            AsyncImage(url: ApiUrls.getImageURL(imagePath: movie.posterPath)) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "film")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                    )
            }
            .frame(width: 100, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .shadow(radius: 4)

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text("Release: \(movie.releaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.subheadline)
                        .foregroundStyle(.yellow)

                    Text("\(movie.voteAverage, specifier: "%.1f") / \(movie.voteCount) votes")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
//    MovieListItemView()
}
