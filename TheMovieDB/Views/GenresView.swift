//
//  GenresView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 29/01/2025.
//

import SwiftUI

struct GenresView: View {
    let title: String
    let genres: [Genre]

    init(title: String = "Genres", genres: [Genre]) {
        self.title = title
        self.genres = genres
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(genres, id: \.id) { genre in
                        NavigationLink(destination: MovieListView(title: "\(genre.name) Movies", movieType: .genre(genre.id))) {
                            Text(genre.name)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
//    GenresView()
}
