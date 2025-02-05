//
//  FavoriteView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 29/01/2025.
//

import SwiftData
import SwiftUI

struct FavoritesView: View {
    @Environment(\.modelContext)
    var modelContext

    @Query(filter: #Predicate<Movie> { $0.isFavorite == true })
    private var favoriteMovies: [Movie]

    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredMovies) { movie in
                    NavigationLink {
                        MovieDetailsView(movieId: movie.id)
                    } label: {
                        MovieListItemView(movie: movie)
                    }
//                    .buttonStyle(.plain)
                }
                .onDelete(perform: deleteMovies)
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "Search movies")
            .toolbar(.hidden, for: .tabBar)
            .navigationTitle("Favorite Movies")
//            .toolbar {
//                EditButton()
//            }
        }
    }

    private var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return favoriteMovies
        } else {
            return favoriteMovies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func deleteMovies(at offsets: IndexSet) {
        for index in offsets {
            let movie = favoriteMovies[index]
            modelContext.delete(movie)
        }
    }
}

#Preview {
//    FavoritesView()
}
