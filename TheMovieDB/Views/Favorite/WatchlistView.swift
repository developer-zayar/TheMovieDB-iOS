//
//  WatchlistView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 04/02/2025.
//

import SwiftData
import SwiftUI

struct WatchlistView: View {
    @Environment(\.modelContext)
    var modelContext

    @Query(filter: #Predicate<Movie> { $0.isWatchlist == true })
    private var watchlistMovies: [Movie]

    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            Group {
                if watchlistMovies.isEmpty {
                    ContentUnavailableView("No Movies in Watchlist", systemImage: "bookmark.slash.fill", description: Text("Add movies to your watchlist to see them here."))
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
            .navigationTitle("Watchlist Movies")
        }
    }

    private var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return watchlistMovies
        } else {
            return watchlistMovies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func deleteMovies(at offsets: IndexSet) {
        for index in offsets {
            let movie = watchlistMovies[index]
            movie.isWatchlist = false
            // TODO: uncomment to delete in both favorite and watchlist
//            modelContext.delete(movie)
        }
    }
}

#Preview {
    WatchlistView()
}
