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
            Group {
                if favoriteMovies.isEmpty {
                    ContentUnavailableView("No Favorite Movies", systemImage: "heart.slash.fill", description: Text("Add movies to your favorites to see them here."))

                } else {
                    Group {
                        if filteredMovies.isEmpty && !searchText.isEmpty {
                            ContentUnavailableView.search
                        } else {
                            List {
                                ForEach(filteredMovies) { movie in
                                    NavigationLink {
                                        MovieDetailsView(movieId: movie.id)
                                    } label: {
                                        MovieListItemView(movie: movie)
                                    }
                                }
                                .onDelete(perform: deleteMovies)
                            }
                            .listStyle(.plain)
                        }
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search movies")
                }
            }
            .toolbar(.hidden, for: .tabBar)
            //            .toolbar {
            //                EditButton()
            //            }
            .navigationTitle("Favorite Movies")
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
            movie.isFavorite = false
            // TODO: uncomment to delete in both favorite and watchlist
//            modelContext.delete(movie)
        }
    }
}

#Preview {
//    FavoritesView()
}
